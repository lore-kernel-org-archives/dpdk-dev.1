Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F3606A32F
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UWzWo6Uk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DB1A40A6B;
	Wed,  4 Nov 2026 14:04:39 +0100 (CET)
Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
 by mails.dpdk.org (Postfix) with ESMTPS id 46D5240281
 for <dev@dpdk.org>; Wed,  4 Nov 2026 14:04:38 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=KjfGDRQfRSN4Hz+X6ygidoFm82Xn5h6g4ohkITvg4FQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793797478; v=1; x=1794402278;
 b=UWzWo6UkXIsQWuNfgBcNopWFfeXTiFRqFz/QRjNGS423AAw33FWGqfNUoTGMcXlkQECYS+Ap
 S33F5sG+I1H7kkns2KuOzSdKBsw6c5DxqARdBvWQvAaFEw0m8M5M9iwZwBphFsg9E2RpahIAAkf
 FfAQfF4dkY5JycGD5Vght14I=
X-Envelope-To: dev@dpdk.org
Received: by smtp.migadu.com with ESMTPS id fd3cb18360a38c0d;
 Wed, 04 Nov 2026 13:04:37 +0000
X-Mizu-Trace-ID: fd3cb18360a38c0d
X-Migadu-Flow: FLOW_OUT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Nov 2026 13:04:37 +0000
Content-Type: multipart/alternative;
 boundary="016fb8b0-e251-407f-af38-6daa4df023d4-1"
From: chengwen.feng@linux.dev
Message-ID: <6b58c0ca561cad60abb0f7105b15e16989b80068@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net/hns3: fix hard-coded default value of UMV space
To: "Shuaisong Yang" <yangshuaisong@h-partners.com>, "Xingui Yang"
 <yangxingui@huawei.com>, "Chengwen Feng" <fengchengwen@huawei.com>, "Hao
 Chen" <chenh@yusur.tech>, "Min Hu (Connor)" <humin29@huawei.com>, "Wei Hu
 (Xavier)" <xavier.huwei@huawei.com>, "Chunsong  Feng"
 <fengchunsong@huawei.com>, "Ferruh Yigit" <ferruh.yigit@amd.com>
Cc: dev@dpdk.org, stable@dpdk.org, yangshuaisong@h-partners.com,
 liuyonglong@huawei.com
In-Reply-To: <20261104124033.3373452-1-yangshuaisong@h-partners.com>
References: <20261104124033.3373452-1-yangshuaisong@h-partners.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--016fb8b0-e251-407f-af38-6daa4df023d4-1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chengwen Feng <fengchengwen@huawei.com mailto:fengchengwen@huaw=
ei.com >



November 4, 2026 at 8:40 PM, "Shuaisong Yang" <yangshuaisong@h-partners.c=
om mailto:yangshuaisong@h-partners.com?to=3D%22Shuaisong%20Yang%22%20%3Cy=
angshuaisong%40h-partners.com%3E > wrote:


>=20
>=20Currently, the driver obtains the PF's UMV (unicast MAC VLAN) table
> space from the board configuration, and falls back to the hard-coded
> default value HNS3_DEFAULT_UMV_SPACE_PER_PF (384 =3D 3072 / 8) when
> the firmware reports an empty umv_space field.
>=20
>=20The hard-coded value is only accurate for chips with a 3072-entry UMV
> table. On chips whose total UMV table size is smaller than 3072, every
> PF still requests 384 entries: the first initialized PF occupies the
> whole table while the others get nothing, which makes adding unicast
> MAC or VLAN entries fail on those ports.
>=20
>=20Fix this by obtaining the UMV size from the device specifications
> command, whose umv_size field is the default value allocated by the
> firmware policy. The requested size is determined at allocation time
> in hns3_init_umv_space(), in the following priority:
>  1. pf->cfg_umv_size, the user specified value from the board
>  configuration
>  2. pf->def_umv_size, the default value reported by the firmware
>  3. the hard-coded default, as the last fallback for old firmware
>=20
>=20Fixes: d51867db65 ("net/hns3: add initialization")
> Cc: stable@dpdk.org
>=20
>=20Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
> ---
>  drivers/net/hns3/hns3_cmd.h | 6 ++++--
>  drivers/net/hns3/hns3_common.c | 1 +
>  drivers/net/hns3/hns3_ethdev.c | 19 ++++++++++++-------
>  drivers/net/hns3/hns3_ethdev.h | 3 ++-
>  4 files changed, 19 insertions(+), 10 deletions(-)
>=20
>=20diff --git a/drivers/net/hns3/hns3_cmd.h b/drivers/net/hns3/hns3_cmd.=
h
> index 2a2ec155ea..473c4f1ec4 100644
> --- a/drivers/net/hns3/hns3_cmd.h
> +++ b/drivers/net/hns3/hns3_cmd.h
> @@ -1008,9 +1008,11 @@ struct hns3_dev_specs_0_cmd {
>  };
>=20=20
>=20 struct hns3_dev_specs_1_cmd {
> - uint8_t rsv0[12];
> + uint8_t rsv0[8];
> + uint16_t umv_size;
> + uint8_t rsv1[2];
>  uint8_t min_tx_pkt_len;
> - uint8_t rsv1[11];
> + uint8_t rsv2[11];
>  };
>=20=20
>=20 struct hns3_query_rpu_cmd {
> diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_com=
mon.c
> index 5e6fbd1f97..a2384ca6c9 100644
> --- a/drivers/net/hns3/hns3_common.c
> +++ b/drivers/net/hns3/hns3_common.c
> @@ -997,6 +997,7 @@ hns3_parse_dev_specifications(struct hns3_hw *hw, s=
truct hns3_cmd_desc *desc)
>  return;
>=20=20
>=20 hw->max_tm_rate =3D rte_le_to_cpu_32(req0->max_tm_rate);
> + hns->pf.def_umv_size =3D rte_le_to_cpu_16(req1->umv_size);
>  }
>=20=20
>=20 static int
> diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_eth=
dev.c
> index 8a898422b1..e45e0d2b16 100644
> --- a/drivers/net/hns3/hns3_ethdev.c
> +++ b/drivers/net/hns3/hns3_ethdev.c
> @@ -1330,19 +1330,26 @@ hns3_init_umv_space(struct hns3_hw *hw)
>  struct hns3_adapter *hns =3D HNS3_DEV_HW_TO_ADAPTER(hw);
>  struct hns3_pf *pf =3D &hns->pf;
>  uint16_t allocated_size =3D 0;
> + uint16_t wanted_umv_size;
>  int ret;
>=20=20
>=20- ret =3D hns3_set_umv_space(hw, pf->wanted_umv_size, &allocated_size=
,
> + wanted_umv_size =3D pf->cfg_umv_size;
> + if (wanted_umv_size =3D=3D 0)
> + wanted_umv_size =3D pf->def_umv_size;
> + if (wanted_umv_size =3D=3D 0)
> + wanted_umv_size =3D HNS3_DEFAULT_UMV_SPACE_PER_PF;
> +
> + ret =3D hns3_set_umv_space(hw, wanted_umv_size, &allocated_size,
>  true);
>  if (ret)
>  return ret;
>=20=20
>=20- if (allocated_size < pf->wanted_umv_size)
> + if (allocated_size < wanted_umv_size)
>  PMD_INIT_LOG(WARNING, "Alloc umv space failed, want %u, get %u",
> - pf->wanted_umv_size, allocated_size);
> + wanted_umv_size, allocated_size);
>=20=20
>=20 pf->max_umv_size =3D (!!allocated_size) ? allocated_size :
> - pf->wanted_umv_size;
> + wanted_umv_size;
>  pf->used_umv_size =3D 0;
>  return 0;
>  }
> @@ -2560,8 +2567,6 @@ hns3_parse_cfg(struct hns3_cfg *cfg, struct hns3_=
cmd_desc *desc)
>  cfg->umv_space =3D hns3_get_field(rte_le_to_cpu_32(req->param[1]),
>  HNS3_CFG_UMV_TBL_SPACE_M,
>  HNS3_CFG_UMV_TBL_SPACE_S);
> - if (!cfg->umv_space)
> - cfg->umv_space =3D HNS3_DEFAULT_UMV_SPACE_PER_PF;
>=20=20
>=20 ext_rss_size_max =3D hns3_get_field(rte_le_to_cpu_32(req->param[2]),
>  HNS3_CFG_EXT_RSS_SIZE_M,
> @@ -2792,7 +2797,7 @@ hns3_get_board_configuration(struct hns3_hw *hw)
>  hns3_set_bit(hw->dcb_info.hw_tc_map, 0, 1);
>  pf->tx_sch_mode =3D HNS3_FLAG_TC_BASE_SCH_MODE;
>=20=20
>=20- pf->wanted_umv_size =3D cfg.umv_space;
> + pf->cfg_umv_size =3D cfg.umv_space;
>=20=20
>=20 return ret;
>  }
> diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_eth=
dev.h
> index fb1a3795cf..4df83e88eb 100644
> --- a/drivers/net/hns3/hns3_ethdev.h
> +++ b/drivers/net/hns3/hns3_ethdev.h
> @@ -841,7 +841,8 @@ struct hns3_pf {
>  bool support_fc_autoneg; /* support FC autonegotiate */
>  bool support_multi_tc_pause;
>=20=20
> - uint16_t wanted_umv_size;
> + uint16_t cfg_umv_size;
> + uint16_t def_umv_size;
>  uint16_t max_umv_size;
>  uint16_t used_umv_size;
>=20=20
>=20--=20
>=202.33.0
>
--016fb8b0-e251-407f-af38-6daa4df023d4-1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><meta http-equiv=3D"Content-Type" content=3D"t=
ext/html; charset=3Dutf-8"></head><body><div>Acked-by: Chengwen Feng &lt;=
<a href=3D"mailto:fengchengwen@huawei.com">fengchengwen@huawei.com</a>&gt=
;</div><div><br></div><p>November 4, 2026 at 8:40 PM, "Shuaisong Yang" &l=
t;<a href=3D"mailto:yangshuaisong@h-partners.com?to=3D%22Shuaisong%20Yang=
%22%20%3Cyangshuaisong%40h-partners.com%3E" tabindex=3D"-1" target=3D"_bl=
ank">yangshuaisong@h-partners.com</a>&gt; wrote:</p><blockquote>Currently=
, the driver obtains the PF's UMV (unicast MAC VLAN) table<br>space from =
the board configuration, and falls back to the hard-coded<br>default valu=
e HNS3_DEFAULT_UMV_SPACE_PER_PF (384 =3D 3072 / 8) when<br>the firmware r=
eports an empty umv_space field.<br><br>The hard-coded value is only accu=
rate for chips with a 3072-entry UMV<br>table. On chips whose total UMV t=
able size is smaller than 3072, every<br>PF still requests 384 entries: t=
he first initialized PF occupies the<br>whole table while the others get =
nothing, which makes adding unicast<br>MAC or VLAN entries fail on those =
ports.<br><br>Fix this by obtaining the UMV size from the device specific=
ations<br>command, whose umv_size field is the default value allocated by=
 the<br>firmware policy. The requested size is determined at allocation t=
ime<br>in hns3_init_umv_space(), in the following priority:<br>  1. pf-&g=
t;cfg_umv_size, the user specified value from the board<br>     configura=
tion<br>  2. pf-&gt;def_umv_size, the default value reported by the firmw=
are<br>  3. the hard-coded default, as the last fallback for old firmware=
<br><br>Fixes: d51867db65 ("net/hns3: add initialization")<br>Cc: stable@=
dpdk.org<br><br>Signed-off-by: Shuaisong Yang &lt;yangshuaisong@h-partner=
s.com&gt;<br>---<br> drivers/net/hns3/hns3_cmd.h    |  6 ++++--<br> drive=
rs/net/hns3/hns3_common.c |  1 +<br> drivers/net/hns3/hns3_ethdev.c | 19 =
++++++++++++-------<br> drivers/net/hns3/hns3_ethdev.h |  3 ++-<br> 4 fil=
es changed, 19 insertions(+), 10 deletions(-)<br><br>diff --git a/drivers=
/net/hns3/hns3_cmd.h b/drivers/net/hns3/hns3_cmd.h<br>index 2a2ec155ea..4=
73c4f1ec4 100644<br>--- a/drivers/net/hns3/hns3_cmd.h<br>+++ b/drivers/ne=
t/hns3/hns3_cmd.h<br>@@ -1008,9 +1008,11 @@ struct hns3_dev_specs_0_cmd {=
<br> };<br> <br> struct hns3_dev_specs_1_cmd {<br>-	uint8_t rsv0[12];<br>=
+	uint8_t rsv0[8];<br>+	uint16_t umv_size;<br>+	uint8_t rsv1[2];<br> 	uin=
t8_t min_tx_pkt_len;<br>-	uint8_t rsv1[11];<br>+	uint8_t rsv2[11];<br> };=
<br> <br> struct hns3_query_rpu_cmd {<br>diff --git a/drivers/net/hns3/hn=
s3_common.c b/drivers/net/hns3/hns3_common.c<br>index 5e6fbd1f97..a2384ca=
6c9 100644<br>--- a/drivers/net/hns3/hns3_common.c<br>+++ b/drivers/net/h=
ns3/hns3_common.c<br>@@ -997,6 +997,7 @@ hns3_parse_dev_specifications(st=
ruct hns3_hw *hw, struct hns3_cmd_desc *desc)<br> 		return;<br> <br> 	hw-=
&gt;max_tm_rate =3D rte_le_to_cpu_32(req0-&gt;max_tm_rate);<br>+	hns-&gt;=
pf.def_umv_size =3D rte_le_to_cpu_16(req1-&gt;umv_size);<br> }<br> <br> s=
tatic int<br>diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hn=
s3/hns3_ethdev.c<br>index 8a898422b1..e45e0d2b16 100644<br>--- a/drivers/=
net/hns3/hns3_ethdev.c<br>+++ b/drivers/net/hns3/hns3_ethdev.c<br>@@ -133=
0,19 +1330,26 @@ hns3_init_umv_space(struct hns3_hw *hw)<br> 	struct hns3=
_adapter *hns =3D HNS3_DEV_HW_TO_ADAPTER(hw);<br> 	struct hns3_pf *pf =3D=
 &amp;hns-&gt;pf;<br> 	uint16_t allocated_size =3D 0;<br>+	uint16_t wante=
d_umv_size;<br> 	int ret;<br> <br>-	ret =3D hns3_set_umv_space(hw, pf-&gt=
;wanted_umv_size, &amp;allocated_size,<br>+	wanted_umv_size =3D pf-&gt;cf=
g_umv_size;<br>+	if (wanted_umv_size =3D=3D 0)<br>+		wanted_umv_size =3D =
pf-&gt;def_umv_size;<br>+	if (wanted_umv_size =3D=3D 0)<br>+		wanted_umv_=
size =3D HNS3_DEFAULT_UMV_SPACE_PER_PF;<br>+<br>+	ret =3D hns3_set_umv_sp=
ace(hw, wanted_umv_size, &amp;allocated_size,<br> 				 true);<br> 	if (re=
t)<br> 		return ret;<br> <br>-	if (allocated_size &lt; pf-&gt;wanted_umv_=
size)<br>+	if (allocated_size &lt; wanted_umv_size)<br> 		PMD_INIT_LOG(WA=
RNING, "Alloc umv space failed, want %u, get %u",<br>-			     pf-&gt;want=
ed_umv_size, allocated_size);<br>+			     wanted_umv_size, allocated_size=
);<br> <br> 	pf-&gt;max_umv_size =3D (!!allocated_size) ? allocated_size =
:<br>-						pf-&gt;wanted_umv_size;<br>+						wanted_umv_size;<br> 	pf-&g=
t;used_umv_size =3D 0;<br> 	return 0;<br> }<br>@@ -2560,8 +2567,6 @@ hns3=
_parse_cfg(struct hns3_cfg *cfg, struct hns3_cmd_desc *desc)<br> 	cfg-&gt=
;umv_space =3D hns3_get_field(rte_le_to_cpu_32(req-&gt;param[1]),<br> 			=
		HNS3_CFG_UMV_TBL_SPACE_M,<br> 					HNS3_CFG_UMV_TBL_SPACE_S);<br>-	if (=
!cfg-&gt;umv_space)<br>-		cfg-&gt;umv_space =3D HNS3_DEFAULT_UMV_SPACE_PE=
R_PF;<br> <br> 	ext_rss_size_max =3D hns3_get_field(rte_le_to_cpu_32(req-=
&gt;param[2]),<br> 					       HNS3_CFG_EXT_RSS_SIZE_M,<br>@@ -2792,7 +27=
97,7 @@ hns3_get_board_configuration(struct hns3_hw *hw)<br> 	hns3_set_bi=
t(hw-&gt;dcb_info.hw_tc_map, 0, 1);<br> 	pf-&gt;tx_sch_mode =3D HNS3_FLAG=
_TC_BASE_SCH_MODE;<br> <br>-	pf-&gt;wanted_umv_size =3D cfg.umv_space;<br=
>+	pf-&gt;cfg_umv_size =3D cfg.umv_space;<br> <br> 	return ret;<br> }<br>=
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethde=
v.h<br>index fb1a3795cf..4df83e88eb 100644<br>--- a/drivers/net/hns3/hns3=
_ethdev.h<br>+++ b/drivers/net/hns3/hns3_ethdev.h<br>@@ -841,7 +841,8 @@ =
struct hns3_pf {<br> 	bool support_fc_autoneg;       /* support FC autone=
gotiate */<br> 	bool support_multi_tc_pause;<br> <br>-	uint16_t wanted_um=
v_size;<br>+	uint16_t cfg_umv_size;<br>+	uint16_t def_umv_size;<br> 	uint=
16_t max_umv_size;<br> 	uint16_t used_umv_size;<br> <br>-- <br>2.33.0</bl=
ockquote><div><br></div></body></html>
--016fb8b0-e251-407f-af38-6daa4df023d4-1--
