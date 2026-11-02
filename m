Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07288606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=NLUKNiwo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D13640EE1;
	Mon,  2 Nov 2026 19:52:58 +0100 (CET)
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 by mails.dpdk.org (Postfix) with ESMTPS id D49D2402E3
 for <dev@dpdk.org>; Mon,  2 Nov 2026 19:52:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=16; q=dns/txt; s=iport01;
 t=1793645576; x=1794855176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=m7C65ntYFKVVJPN0OVUczdVZ0qfkmsqNuLpNLPItyqg=;
 b=NLUKNiwoHPKP1lsdRwUlu/WnjnzfxQ/14p8VF3Z+01mskLu6TOmtrQkA
 XDAB7HQ/JXReDFcTt3lIiGe/TvfLWpsPt7xWU11OzivALKv7pVL4+q7b3
 85hlgMbqop6FKNuK/LP8h/6fgCthT71MTtPvHdvsXfCNFuU7b0OQLHG50
 Ob4jzoKhOvEc1WE73E7kW6M52cyd73/sGQTisCm/vjDDqxx4p4YRPp1Jw
 Chj5B4GoTFCvq3D2v02zV5PFtJqxn+2yWZe6anCDo1GVqtDoz67oHJOKz
 WAn/D6BV44uxhHXEgWrNpv/HDmPCsGjP/FrlbH4yjxARUulFikpSlVFN2 A==;
X-CSE-ConnectionGUID: tuK6RndNSgSZ5hW/RqWpeQ==
X-CSE-MsgGUID: /tRscfZDSDechuCh+5B17w==
X-IPAS-Result: =?us-ascii?q?A0BfAwBd2+hq/44QJK1aHgEBCxIMggULhC1ChSCwFoFqF?=
 =?us-ascii?q?A8BAQEPUQQBAYUBAgICjhwCJjQJDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyQEwIBAxkKDwFGEAsaAiYCAkYQgxuCdQO7RnqBMoEBhH7ZS?=
 =?us-ascii?q?4F0FYEKLohfAYFxgxJ2hH0nFQaBSUSBR4J5PoUQgw+CagSCIoEMlwUJSXgcA?=
 =?us-ascii?q?1ksAVUTFwsHBWNCQwOBBiNLBS0dgSMhHRcRHlgbBgUSICpBQ0QEE4ESgQddg?=
 =?us-ascii?q?SsoXQECH0YtFYF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8C?=
 =?us-ascii?q?SY/FQxbCwsaBRpHCAILAgx0KBEQEx0eJC8FHCY9bT03FRkEPbEZjCiCIaEPh?=
 =?us-ascii?q?CmhdzODcQGmfpkIqUSBaDyBWU0jFYMjUhkP4HwmdAcCBw8Ck3EBAQ?=
IronPort-Data: A9a23:uRnBXqIpng55IeloFE+RhJQlxSXFcZb7ZxGr2PjKsXjdYENS02FSm
 mJJC2qFbveIYGf8KN8nOtu39UJQuZ6DzIVgSwcd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH8gmYuajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1yEWJoB4sU3N14OlMT9
 cNfEikydh260rfeLLKTEoGAh+wqKM3teYdasXZ6wHSBULAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzNnwsYDUXUrsTIIgineylrnL+aDZf7lmSoMLb5kCClFYvjuO3aoe9ltqiAtlvhU2Wl
 E7902nyAgwxNJ/C42Pa7Sf57gPItWahMG4IL5W0++BCjEWfxSoUEhJ+fUCnrOG5h0iWXd9DN
 EsO+TIqsK04+VbtScPyNyBUu1aNuhoaHt4VGOog5UTVl+zf4h2SAS4PSTsphMEaifLajAcCj
 jeh9+4FzxQ22FFJYRpxLoupkA4=
IronPort-HdrOrdr: A9a23:GPv5rK1Bq7mglaf62KwIbAqjBJIkLtp133Aq2lEZdPWaSKClfq
 eV7ZEmPH7P+VQssR4b9+xoVJPrfZqYz/5ICOoqTNOftXfd2VdARbsKheDfKn/bak7DH4Vmup
 uIHZISNPTASX5nkM39/A60V/wkwNWB7eSUoN229QYLcemvAJsQljuQzW2gYytLeDU=
X-Talos-CUID: =?us-ascii?q?9a23=3AmmiI62nXQgMFv8cqB0YEkaUJaU/XOWHA7ynqJUO?=
 =?us-ascii?q?eMmlSeuCVdhiq4Zx8nvM7zg=3D=3D?=
X-Talos-MUID: 9a23:065uiAXVeqyZyH/q/HjwvippOvVE2IijA0AQupVF5uPdajMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,191,1787011200"; d="scan'208";a="902663225"
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
 by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 02 Nov 2026 18:52:55 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alln-l-core-05.cisco.com (Postfix) with ESMTPS id 1D0C318000217;
 Mon,  2 Nov 2026 18:52:55 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 0/1] log: add name query functions
Date: Mon, 02 Nov 2026 13:52:54 -0500
Message-Id: <179364557446.2.5239521478746961990.0000-dpio-773-friendly-nudge.patch@cisco.com>
In-Reply-To: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
References: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-05.cisco.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

friendly nudge
