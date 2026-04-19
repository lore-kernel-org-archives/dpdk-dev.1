Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB16EA71AA
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 22:20:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49ED5402B5;
	Mon, 20 Apr 2026 00:20:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B06A44026E
 for <dev@dpdk.org>; Mon, 20 Apr 2026 00:20:02 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6F74120735;
 Mon, 20 Apr 2026 00:20:02 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] maintainers: update dts maintainer email
Date: Mon, 20 Apr 2026 00:20:00 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657FE@smartserver.smartshare.dk>
In-Reply-To: <20260419194836.27602-1-patrickrobb1997@gmail.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] maintainers: update dts maintainer email
Thread-Index: AdzQNZIDUeuB2YIRTpa3VL0x6FkihQAFGeOQ
References: <20260419194836.27602-1-patrickrobb1997@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Patrick Robb" <patrickrobb1997@gmail.com>,
	<thomas@monjalon.net>
Cc: <dev@dpdk.org>, <aconole@redhat.com>, <lylavoie@iol.unh.edu>,
 <abailey@iol.unh.edu>, <dmarx@iol.unh.edu>, <knimoji@iol.unh.edu>,
 <luca.vizzarro@arm.com>
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

> diff --git a/.mailmap b/.mailmap
> index 0e0d83e1c6..0ce0cfc1a8 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1232,7 +1232,7 @@ Patrick Fu <patrick.fu@intel.com>
>  Patrick Kutch <patrick.g.kutch@intel.com>
>  Patrick Lu <patrick.lu@intel.com>
>  Patrick MacArthur <patrick@patrickmacarthur.net>
> -Patrick Robb <probb@iol.unh.edu>
> +Patrick Robb <patrickrobb1997@gmail.com>

In the mailmap file, both addresses should be present, to tie them =
together:
-Patrick Robb <probb@iol.unh.edu>
+Patrick Robb <patrickrobb1997@gmail.com> <probb@iol.unh.edu>

Look at other entries with multiple addresses, e.g.:
Thomas Monjalon <thomas@monjalon.net> <thomas.monjalon@6wind.com>

With that fixed,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

