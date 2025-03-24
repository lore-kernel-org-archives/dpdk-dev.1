Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5A1C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 17:00:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 840FA40BA6;
	Mon, 24 Mar 2025 18:00:03 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 31F9940A71
 for <dev@dpdk.org>; Mon, 24 Mar 2025 18:00:02 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9BE39114021D;
 Mon, 24 Mar 2025 13:00:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 24 Mar 2025 13:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1742835601;
 x=1742922001; bh=Il28qzjed933gJl5uKk4pmiw4R0oNlU+F2i+VOPPxDw=; b=
 lARwfo9LLIGmRkz2gG5zXUEhxNBhIBZ5ug+M04aOowz/37yimLqxkocYsM1Gs9z1
 /L8L9GhOFrxg+TiM4jaZ+V0zTE6JUgKtBKwxUUiOyAviQYgZxHZyEcOQAww3F0Nz
 p5P3BOWl4lxc1qQDdE1KwNarkJe1i6vmRrpDrbJNzaKNwrVcMhDsluNqctv1nya5
 cXvomVMFr46fCW4zdcRwoVkdJgDADDpMAPK3DjdSRzqmkVLIChpBJuF+WPnaCSOh
 xPInlZexDOhnUfNiX5H+iT97c9xO0fukcW87oWWro8s7Ky6YvgOJ1swm4C9H1wBE
 I79p+63w2mk5hlBHwdi7yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742835601; x=
 1742922001; bh=Il28qzjed933gJl5uKk4pmiw4R0oNlU+F2i+VOPPxDw=; b=K
 JXsr5plMCMJImrlvlTrGQva3g9aR1HG6jl5GCqO39qXmaXAGsE9i7rm6y8E7RNC+
 ijyjr+tF8UBSxkOrI8IaJU3yvmc8fTKGXe4dj38sBon7pV7dCe5XynnJLGTSkHFL
 Kd2B44jICNzWxUxJvSYavlcIWWEITXtJUt/IlNvpqacn/sqCJGT1KZY8F65M9+eQ
 9jvoU5ryRsHnefZcXjbvBDy5C2qMeSA11HzGpBFQQtKkWDScR7/li+s8B2FJWDp2
 WkipFxXAvdu8ZyNLYNryxUUCjcJwl8b4rdDJbYqL4razh9VrdrPwgd0/2Fr7D2IA
 3aJFxJTFJEp1T1uQi5u1Q==
X-ME-Sender: <xms:kI_hZ2chLjF0LVHYJFeYmtFEyc4TcDtNxwddV6HWONlcdbaPTwezNw>
 <xme:kI_hZwPfkMfcL8lH9w9iryeR318mpbpOpzjFS-8iFZm3x6nA2i9hr5fpHqCIlveiW
 ArDDVlyeU5JaqlDjA>
X-ME-Received: <xmr:kI_hZ3j-L0kFKvfaKoSUektpwHP1gwx7ari7CxC3jCXDAScLqcfzXhAY_K6mQM7dGW0UNTUew7uJMwAI0HCDSSPwVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtfeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdej
 vedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrg
 hslhgrnhgusehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhr
 ghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
 dprhgtphhtthhopehhrghijhhivgdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehm
 sgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomh
X-ME-Proxy: <xmx:kI_hZz-VkjM6-9q9omy_4XRUn2Xc3xcIu5uzR8wCNzioVqO_kcn0Vw>
 <xmx:kI_hZyvq1xtEmWJ5EHph0C4Yde-Z4bvOyOlH6rH2H97aLcvwfEfJAA>
 <xmx:kI_hZ6Hy24FkQuAxlbCN8EQgmJ0KMDxPGfa5TD2usgLfMH6-Yc0q8g>
 <xmx:kI_hZxOGrKP26rF5jxkXSRiUQ8AG3OR1vOYag8YOZOriQZB2u77S_Q>
 <xmx:kY_hZ0UysV8X1TYmqmyklbwPbGSKbRvvShqntq87VkAoVxDMf1Dd55Km>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 12:59:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, haijie1@huawei.com,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v3] app/testpmd: fix VLAN header parsing
Date: Mon, 24 Mar 2025 17:59:57 +0100
Message-ID: <6263413.MHq7AAxBmi@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB4B@smartserver.smartshare.dk>
References: <20250323122822.90407-1-rasland@nvidia.com>
 <20250324093349.26509-1-rasland@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB4B@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

24/03/2025 14:18, Morten Br=C3=B8rup:
> > From: Raslan Darawsheh [mailto:rasland@nvidia.com]
> > Sent: Monday, 24 March 2025 10.34
> >=20
> > When processing VLAN or QinQ packets, an infinite loop occurred,
> > preventing the csum forward engine from proceeding and causing
> > testpmd to hang during shutdown attempts.
> >=20
> > Updated the `get_ethertype_by_ptype` function to correctly parse
> > VLAN headers.
> >=20
> > Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
> > Cc: haijie1@huawei.com
> >=20
> > Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
> > ---
> > v3: fixed wrong indentation
> >     add boundaries check for 8 VLANs at max
> >=20
> > v2: update commit log
> >     fixed pointer handling to actually move the pointer
> > ---
> >  app/test-pmd/csumonly.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> > index 5b906eaa53..710967ca4d 100644
> > --- a/app/test-pmd/csumonly.c
> > +++ b/app/test-pmd/csumonly.c
> > @@ -59,6 +59,8 @@
> >  #define GRE_SUPPORTED_FIELDS	(GRE_CHECKSUM_PRESENT | GRE_KEY_PRESENT
> > |\
> >  				 GRE_SEQUENCE_PRESENT)
> >=20
> > +#define MAX_VLAN_HEADERS 8
> > +
> >  /* We cannot use rte_cpu_to_be_16() on a constant in a switch/case */
> >  #if RTE_BYTE_ORDER =3D=3D RTE_LITTLE_ENDIAN
> >  #define _htons(x) ((uint16_t)((((x) & 0x00ffU) << 8) | (((x) &
> > 0xff00U) >> 8)))
> > @@ -466,9 +468,10 @@ pkts_ip_csum_recalc(struct rte_mbuf **pkts_burst,
> > const uint16_t nb_pkts, uint64
> >  static uint32_t
> >  get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
> >  {
> > -	struct rte_vlan_hdr *vlan_hdr;
> > +	struct rte_vlan_hdr *vlan_hdr, *max_vlans;
> >  	uint16_t ethertype;
> >=20
> > +
>=20
> Please omit adding an extra empty line.
>=20
> >  	switch (ptype) {
> >  	case RTE_PTYPE_L3_IPV4:
> >  	case RTE_PTYPE_L3_IPV4_EXT:
> > @@ -486,10 +489,13 @@ get_ethertype_by_ptype(struct rte_ether_hdr
> > *eth_hdr, uint32_t ptype)
> >  		return _htons(RTE_ETHER_TYPE_IPV6);
> >  	default:
> >  		ethertype =3D eth_hdr->ether_type;
> > -		while (eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_VLAN)
> > ||
> > -			eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {
> > -			vlan_hdr =3D (struct rte_vlan_hdr *)
> > -				((char *)eth_hdr + sizeof(*eth_hdr));
> > +		vlan_hdr =3D (struct rte_vlan_hdr *) RTE_PTR_ADD(eth_hdr,

useless type cast

> > +					offsetof(struct rte_ether_hdr,
> > ether_type));
>=20
> Above line indentation with 2, not 3 TABs.
>=20
> > +		max_vlans =3D vlan_hdr + MAX_VLAN_HEADERS;
> > +		while (((ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||
>=20
> Superfluous parenthesis: "while ( ((x || y)) && z)".
>=20
> > +			ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ))) &&
> > +			vlan_hdr < max_vlans) {
>=20
> Above two lines indentation with 2, not 1 TAB.
>=20
> > +			vlan_hdr++;
> >  			ethertype =3D vlan_hdr->eth_proto;
> >  		}
> >  		return ethertype;
> > --
> > 2.39.5 (Apple Git-154)
>=20
> With above nits fixed (can be fixed when merging),
> Reviewed-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

All nits fixed and applied, thanks.


