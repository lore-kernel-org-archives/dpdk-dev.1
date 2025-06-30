Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1020C7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFF3540264;
	Mon, 30 Jun 2025 13:08:17 +0200 (CEST)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com
 [99.78.197.218]) by mails.dpdk.org (Postfix) with ESMTP id 2D5304025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751281697; x=1782817697;
 h=from:to:cc:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version:subject;
 bh=29R/IMvtg0MyC1MMjV7J8wGMR3NCi5hgITnHjnJjdjA=;
 b=tKa1++OeMpv+dxq6Em8Dv0dypIBUn/UQRFYfeG9XUIZBGy4lkobFkPJH
 Ds9RwZfYvgwncSXB/HdDEK3T1/XwrkbvrsNF5ifKTSCrMP75Uzr4I9epW
 rmUMB7xMR7FVPjab7wqZzQW5tg/73KpX5XSX2BUJd6EshNGuMygcKT+mi
 HoDK1cJ0ac0wgXembhz9ap5xeqj8WkZBBF1LXMyCIE59OvLIeW7K63K1K
 rucoD2v6VY7tTFzPmPhdU03kUA1odCb5qs4JoA6BtdCKowH05XzDMXB/3
 J9XowYhDRdO6tw3VSlD2XIbBLyf3i0pw73tKJ/pOqouYyQCRSpr8SwzCh w==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="420547478"
Subject: RE: [PATCH v4 0/7] net/ena: release 2.13.0
Thread-Topic: [PATCH v4 0/7] net/ena: release 2.13.0
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:08:14 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:43444]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.139:2525]
 with esmtp (Farcaster)
 id 2a9c74d7-76b8-4002-b5df-6cd874a69438; Mon, 30 Jun 2025 11:08:12 +0000 (UTC)
X-Farcaster-Flow-ID: 2a9c74d7-76b8-4002-b5df-6cd874a69438
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:08:12 +0000
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:08:12 +0000
Received: from EX19D007EUA002.ant.amazon.com ([fe80::1295:20d9:141e:47cc]) by
 EX19D007EUA002.ant.amazon.com ([fe80::1295:20d9:141e:47cc%3]) with
 mapi id 15.02.1544.014; Mon, 30 Jun 2025 11:08:12 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Thread-Index: AQHb6RXdQA5MFp0IjUCTPfPSSzZbLbQbiYmA
Date: Mon, 30 Jun 2025 11:08:12 +0000
Message-ID: <6be9d6041a3e4cdea8ed6609c32f9b38@amazon.com>
References: <20250528102531.9876-1-shaibran@amazon.com>
 <20250629094931.05268741@hermes.local>
In-Reply-To: <20250629094931.05268741@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.213.9]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday, June 29, 2025 7:50 PM
> To: Brandes, Shai <shaibran@amazon.com>
> Cc: dev@dpdk.org
> Subject: RE: [EXTERNAL] [PATCH v4 0/7] net/ena: release 2.13.0
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick
> links or open attachments unless you can confirm the sender and know the
> content is safe.
>=20
>=20
>=20
> On Wed, 28 May 2025 13:25:24 +0300
> Shai Brandes <shaibran@amazon.com> wrote:
>=20
> > This patchset includes an upgrade of the ENA HAL, introduces a new
> > feature, and addresses three bug fixes.
> >
> > Thank you in advance to the net maintainers and community members for
> > your time and effort reviewing the code.
> >
> > Best regards,
> > Shai Brandes
> > AWS Elastic Network Adapter team
>=20
> Could you check against current main branch.
> This no longer applies, either it already got merged or something changed=
.
Hi Stephen, the merge conflict occurred due to updates in the release notes=
 after we initially uploaded the patchset.
I've rebased the changes on top of origin/main and will submit a revised ve=
rsion shortly. I'll go ahead and abandon the previous set.

Just a quick note, we originally submitted the patchset over a month ago, a=
nd it has been in the "awaiting upstream" state since then.
I noticed that rc2 has already been released.
we would greatly appreciate it if you could include the ENA changes in rc3.
ENA is a self-contained module, and the previous maintainer approved that m=
ode of operation. Hopefully, an exception can be made in this case.
Thanks again for your time and continued support.=20
