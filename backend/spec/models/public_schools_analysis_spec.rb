require 'rails_helper'

RSpec.describe PublicSchoolsAnalysis, type: :model do
  before do
    @schoolSubdistrictMock = class_double('SchoolSubdistrict')
    @schoolSubdistrictObject = double()

    allow(@schoolSubdistrictMock).to receive(:version).and_return(@schoolSubdistrictObject)

    allow(@schoolSubdistrictObject).to receive(:intersecting_with_bbls).and_return([
      {
        district: '15',
        subdistrict: '1'
      }
    ])

    allow(@schoolSubdistrictObject).to receive(:for_subdistrict_pairs).and_return([
      {
        district: '15',
        subdistrict: '1',
        school_choice_ps: false,
        school_choice_is: true,
        # geometry in Well Known Binary of district 15 subdistrict 1--> this subdistrict has both an lcgms school and an sca project
        geom: "0106000020E6100000010000000103000000010000007C000000A4FE7A85058152C0A3923A014D544440A33F34F3E48052C0BE33DAAA24544440A75A0BB3D08052C0355EBA490C54444090F5D4EAAB8052C046ED7E15E053444033FE7DC6858052C08D25AC8DB1534440D21C59F9658052C066A3737E8A534440560C5707408052C0957F2DAF5C534440E08442041C8052C05E2EE23B315344402237C30DF87F52C086E5CFB705534440401361C3D37F52C0EACE13CFD9524440591822A7AF7F52C0B37DC85BAE5244404CFF9254A67F52C0772E8CF4A2524440B30C71AC8B7F52C0DB34B6D78252444067B45549647F52C076FBAC325352444020D1048A587F52C0F19D98F56252444020B41EBE4C7F52C0BADDCB7D725244401AC05B20417F52C0471FF3018152444069519FE40E7F52C0D3669C86A8524440292504ABEA7E52C054E3A59BC452444041649126DE7E52C01FF30181CE524440C0046EDDCD7E52C0FB05BB61DB52444057CD7344BE7E52C060E811A3E7524440E9263108AC7E52C0B8E864A9F5524440FDDCD0949D7E52C0F437A11001534440F850A2258F7E52C04DA088450C5344403B8BDEA9807E52C06BD619DF17534440F086342A707E52C053E8BCC62E534440B1169F02607E52C0BC1FB75F3E534440DC0E0D8B517E52C0B77F65A5495344408690F3FE3F7E52C0B4006DAB595344400C3F389F3A7E52C00457790261534440069CA564397E52C0CFF8BEB8545344405587DC0C377E52C09F573CF548534440096CCEC1337E52C0B5DD04DF345344409BC8CC052E7E52C041F2CEA10C534440C6DD205A2B7E52C068AF3E1EFA52444015E3FC4D287E52C0261E5036E55244406B274A42227E52C01DE90C8CBC524440077C7E18217E52C0FD4AE7C3B3524440DF50F86C1D7E52C0C34659BF995244402E7079AC197E52C0BE839F3880524440664D2CF0157E52C02577D844665244400D6D0036207E52C0CD936B0A6452444053CE177B2F7E52C058CB9D9960524440910A630B417E52C01E3526C45C524440C498F4F7527E52C0732B84D55852444086CABF96577E52C0382D78D1575244408FC2F5285C7E52C0FD2E6CCD56524440F1D4230D6E7E52C082A966D6525244407EFCA5457D7E52C07E54C37E4F5244406B2C616D8C7E52C0A983BC1E4C5244401096B1A19B7E52C0A52E19C74852444068CA4E3FA87E52C0321F10E84C5244400C957F2DAF7E52C0F3FFAA23475244400F99F221A87E52C05C38109205524440280F0BB5A67E52C02942EA76F6514440F6D4EAABAB7E52C03C66A032FE514440DEE34C13B67E52C0A98427F4FA51444078B6476FB87E52C06CCD565EF25144407FC16ED8B67E52C0C2DA183BE1514440D80C7041B67E52C0079ACFB9DB5144402DE92807B37E52C000529B38B95144404E266E15C47E52C0DE1D19ABCD5144403621AD31E87E52C0E6EAC726F951444063096B63EC7E52C0DE74CB0EF15144403D635FB2F17E52C01F1329CDE6514440B5183C4CFB7E52C0F8325184D45144409D137B681F7F52C00000000000524440444DF4F9287F52C07A17EFC7ED5144404B8FA67A327F52C0A2D45E44DB514440F3C81F0C3C7F52C04C70EA03C9514440E2C80391457F52C0E4A08499B651444072C0AE264F7F52C04D4D8237A4514440323CF6B3587F52C08675E3DD91514440DA756F45627F52C08F19A88C7F51444099F1B6D26B7F52C098BD6C3B6D514440596DFE5F757F52C090F63FC05A514440486DE2E47E7F52C03A92CB7F48514440BFF4F6E7A27F52C0E256410C74514440B7B24467997F52C0A92EE0658651444028BB99D18F7F52C011FE45D09851444075AC527AA67F52C009DFFB1BB4514440577C43E1B37F52C0B9C2BB5CC45144401A19E42EC27F52C0D4282499D551444056B950F9D77F52C0D3FA5B02F05144409DBCC804FC7F52C04B3B35971B5244409CF9D51C208052C06473D53C475244402CF180B2298052C02C280CCA3452444033333333338052C095D409682252444093A641D13C8052C09E78CE16105244406B64575A468052C0D7A02FBDFD51444042226DE34F8052C0404D2D5BEB5144401AE0826C598052C079758E01D9514440C119FCFD628052C05395B6B8C6514440B119E0826C8052C0EBC5504EB4514440514B732B848052C0A1832EE1D0514440C898BB96908052C064062AE3DF514440BA6B09F9A08052C0FA25E2ADF35144405793A7ACA68052C0E5B67D8FFA514440AF93FAB2B48052C0ADC266800B524440AFD007CBD88052C05587DC0C37524440EF54C03DCF8052C0ECDADE6E49524440DD26DC2BF38052C0833463D174524440D05E7D3CF48052C0118DEE2076524440F9A067B3EA8052C0D8648D7A88524440C9022670EB8052C0A2EF6E6589524440075C57CC088152C031D3F6AFAC52444030D5CC5A0A8152C095641D8EAE524440A7EB89AE0B8152C064AC36FFAF524440DC12B9E00C8152C0F304C24EB15244403AE7A7380E8152C0225514AFB25244405E143DF0318152C0AC00DF6DDE524440450F7C0C568152C02541B8020A53444023D8B8FE5D8152C0DEE522BE13534440F836FDD98F8152C09B1F7F69515344401AA20A7F868152C0F60CE19865534440B6D95889798152C0B1DF13EB545344407EAB75E2728152C0B0C8AF1F62534440227024D0608152C0C8B60C384B53444062DA37F7578152C031EE06D15A5344400E1137A7928152C0C21550A8A753444092240857408152C0D2A8C0C9365444409031772D218152C03F8C101E6D544440A4FE7A85058152C0A3923A014D544440"
      }
    ])

    # #   allow(@schoolSubdistrictMock).to receive(:st_union_subdistricts).and_return(
    #     RGeo::Cartesian.preferred_factory(srid: 4326).parse_wkt("MULTIPOLYGON (((-74.015962 40.6586, -74.013974 40.657369, -74.012738 40.656625, -74.010493 40.655276, 
    #     -74.008165 40.653856, -74.006224 40.652664, -74.003908 40.651266, -74.00171 40.64994, -73.999515 40.648612, -73.9973 40.647272, -73.995096 40.645946, -73.994527 40.645598, 
    #     -73.9929 40.644618, -73.990496 40.643164, -73.989779 40.643645, -73.989059 40.644119, -73.98835 40.644562, -73.985284 40.645768, -73.983073 40.646625, -73.982309 40.646927, 
    #     -73.981315 40.64732, -73.980363 40.647694, -73.97925 40.648122, -73.978368 40.64847, -73.977487 40.648812, -73.976603 40.649166, -73.975596 40.649865, -73.97461 40.650341, 
    #     -73.973727 40.650685, -73.972656 40.651174, -73.972328 40.651398, -73.972253 40.651023, -73.97211 40.650664, -73.971909 40.650051, -73.971559 40.648823, -73.971396 40.648258, 
    #     -73.97121 40.64762, -73.970841 40.646379, -73.97077 40.646111, -73.970546 40.645317, -73.970317 40.644538, -73.970089 40.643746, -73.970716 40.643678, -73.971648 40.643573, 
    #     -73.97272 40.643456, -73.973814 40.643336, -73.974096 40.643305, -73.974375 40.643274, -73.975467 40.643153, -73.976396 40.643051, -73.977321 40.642948, -73.978249 40.642846, 
    #     -73.979019 40.642972, -73.979442 40.642796, -73.979012 40.640795, -73.978925 40.640334, -73.979228 40.64057, -73.979863 40.640471, -73.980007 40.640209, -73.97991 40.639686, 
    #     -73.979874 40.639518, -73.979677 40.638465, -73.980718 40.639089, -73.982922 40.640416, -73.983178 40.640169, -73.983502 40.639856, -73.984088 40.639298, -73.986292 40.640625, 
    #     -73.986876 40.640069, -73.987456 40.639504, -73.98804 40.638947, -73.988621 40.638385, -73.989206 40.637824, -73.989789 40.637264, -73.990373 40.636705, -73.990956 40.636146, 
    #     -73.991539 40.635582, -73.99212 40.635025, -73.994318 40.636354, -73.993738 40.636914, -73.993153 40.637476, -73.994536 40.638309, -73.995354 40.638805, -73.996227 40.639331, 
    #     -73.997557 40.640137, -73.999757 40.641467, -74.00196 40.642799, -74.002545 40.642236, -74.003125 40.641675, -74.003712 40.641116, -74.004294 40.640556, -74.004876 40.639995, 
    #     -74.005458 40.639435, -74.006042 40.638877, -74.006623 40.638315, -74.008067 40.639187, -74.008825 40.639645, -74.009825 40.640249, -74.010173 40.640459, -74.011029 40.640976, 
    #     -74.013232 40.642305, -74.012649 40.642866, -74.014842 40.64419, -74.014907 40.64423, -74.014325 40.64479, -74.01437 40.644818, -74.016162 40.645895, -74.016257 40.645952, 
    #     -74.016338 40.645996, -74.016411 40.646036, -74.016493 40.646078, -74.018673 40.647413, -74.020877 40.648743, -74.021362 40.64904, -74.024405 40.650922, -74.023834 40.651538, 
    #     -74.023043 40.651029, -74.022637 40.651432, -74.021534 40.650733, -74.020994 40.651209, -74.024576 40.653554, -74.019552 40.657922, -74.01765 40.65958, -74.015962 40.6586)))")
    # # )

    stub_const("#{CeqrData}::SchoolSubdistrict", @schoolSubdistrictMock)
  end

  # bbl within district 1 subdistrict 15
  let(:project) { create(:project, build_year: 2026, bbls: [3007770001]) }
  let(:data_package) { create(:data_package) }
  let(:analysis) { create(:public_schools_analysis, project: project, data_package: data_package) }

# multipliers
  describe "should set multipliers on save and update" do
    it "sets multipliers correctly" do
      expect(analysis.multipliers['districts'][0]['csd']).to eq(15)
      expect(analysis.multipliers['districts'][0]['borocode']).to eq('bk')
    end
  end

## subdistricts_from_db
  describe "should set subdistricts on save and update" do
    it "sets subdistricts correctly" do
      expect(analysis.subdistricts_from_db[0]['district']).to eq('15')
      expect(analysis.subdistricts_from_db[0]['subdistrict']).to eq('1')
    end
  end

  ## es_school_choice & is_school_choice
    describe "should set es_school_choice and is_school_choice on save and update" do
      it "sets es_school_choice and is_school_choice correctly" do
        expect(analysis.es_school_choice).to eq(false)
        # expect(analysis.is_school_choice).to eq(true)
      end
    end

## bluebook
  describe "should set bluebook on save and update" do
    it "sets bluebook correctly" do
      expect(analysis.bluebook[0]['district']).to eq('15')
      expect(analysis.bluebook[0]['subdistrict']).to eq('1')
    end
  end

## lcgms
    describe "should set lcgms on save and update" do
      it "sets lcgms correctly" do
        expect(analysis.lcgms[0]['district']).to eq('15')
        expect(analysis.lcgms[0]['subdistrict']).to eq('1')
      end
    end

## sca_projects
    describe "should set sca projects on save and update" do
      it "sets sca projects correctly" do
        expect(analysis.sca_projects[0]['district']).to eq('15')
        expect(analysis.sca_projects[0]['subdistrict']).to eq('1')
      end
    end

## future_enrollment_multipliers
  describe "should set future_enrollment_multipliers on save and update" do
    it "sets future_enrollment_multipliers correctly" do
      expect(analysis.future_enrollment_multipliers[0]['district']).to eq('15')
      expect(analysis.future_enrollment_multipliers[0]['subdistrict']).to eq('1')
    end
  end

## hs_projections
  describe "should set hs_projections on save and update" do
    it "sets hs_projections correctly" do
      borough = analysis.hs_projections.map {|n| n['borough']}
      expect(borough).to eq(['brooklyn'])
    end
  end

## future_enrollment_projections
    describe "should set future_enrollment_projections on save and update" do
      it "sets future_enrollment_projections correctly" do
        expect(analysis.future_enrollment_projections[0]['district']).to eq('15')
      end
    end

## hs_students_from_housing
    describe "should set hs_students_from_housing on save and update" do
      it "sets hs_students_from_housing correctly" do
        # new_students in table sca_housing_pipeline_by_boro for Brooklyn is 4802
        expect(analysis.hs_students_from_housing).to eq(4802)
      end
    end

## future_enrollment_new_housing
    describe "should set future_enrollment_new_housing on save and update" do
      it "sets set future_enrollment_new_housing correctly" do
        expect(analysis.future_enrollment_new_housing[0]['district']).to eq('15')
        expect(analysis.future_enrollment_new_housing[0]['subdistrict']).to eq('1')
      end
    end

  ## doe_util_changes
  # TODO: this test can be made more specific
  describe "should set doe_util_changes on save and update" do
    it "sets set doe_util_changes correctly" do
      blubookBuildingIds = analysis.bluebook.map {|b| b['bldg_id']}
      lcmgsBuildingsIds = analysis.lcgms.map {|b| b['bldg_id']}

      allBuildingIds = (blubookBuildingIds + lcmgsBuildingsIds).uniq

      doeBuildingIds = analysis.doe_util_changes.map {|b| b['bldg_id']}.uniq # two items for district 15 subdistrict 1

      expect(allBuildingIds).to include(doeBuildingIds[0], doeBuildingIds[1])
    end
  end
end