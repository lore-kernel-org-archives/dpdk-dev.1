Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD3FC54FCD
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 09:00:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94EB1402BB;
	Sat,  1 Aug 2026 11:00:42 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F0B0D40299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 11:00:40 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9EFCF207AB;
 Sat,  1 Aug 2026 11:00:40 +0200 (CEST)
Subject: ice driver compiler warning
Date: Sat, 1 Aug 2026 11:00:38 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659AF@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-class: urn:content-classes:message
Thread-Topic: ice driver compiler warning
Thread-Index: Ad0hlDj03lwCyMYfSDqwiUSBQJBSKw==
X-MimeOLE: Produced By Microsoft Exchange V6.5
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <bruce.richardson@intel.com>, "Anatoly Burakov" <anatoly.burakov@intel.com>
Cc: <dev@dpdk.org>
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

ice driver maintainers,

Is the ice base driver still defining structure fields with [0], or has =
it been updated to use []?
Maybe the workaround in meson.build is not required anymore:

# Bugzilla ID: 678
if (toolchain =3D=3D 'gcc' and =
cc.version().version_compare('>=3D11.0.0'))
    error_cflags +=3D ['-Wno-array-bounds']
endif

Ref:
https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/ice/base/meson.b=
uild#L49


Venlig hilsen / Kind regards,
-Morten Br=F8rup


