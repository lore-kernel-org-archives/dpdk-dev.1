Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD234C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 17:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93B4C40695;
	Fri, 31 Jan 2025 18:34:47 +0100 (CET)
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
 by mails.dpdk.org (Postfix) with ESMTP id 6DF84402EE
 for <dev@dpdk.org>; Fri, 31 Jan 2025 18:34:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1738344886; x=1769880886;
 h=from:date:cc:to:mime-version:message-id:subject:
 content-transfer-encoding;
 bh=wR6hjNAL1vi8jBS0gQb6lAv1lqgkBfsqdTAy9WUscuY=;
 b=Hir1I7KH3wLfs+QWbz0IWz+JFkIDrY7yre/bFwb6R4xMO8DHj6CCPCQa
 br4E1sVi1zsa2q7Jv9cDXtZrztIKqDfyZBc51qwRBGWDcElnvq5X7ywOw
 4NpJTfbXWu1vldg2gRwGNk2331UeJ/QLhMdz7Tq6sh+KR0fn0x3pPdHcx g=;
X-CSE-ConnectionGUID: AjW++uQCToaJyPvIzCTXfQ==
X-CSE-MsgGUID: F94CZ2MhSqOnAo4YFKYLfQ==
X-IronPort-AV: E=Sophos;i="6.13,249,1732575600"; d="scan'208";a="28800833"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 31 Jan 2025 18:34:46 +0100
From: "Ariel Otilibili-Anieli" <otilibil@eurecom.fr>
Content-Type: text/plain; charset="utf-8"
X-Forward: 185.13.181.2
Date: Fri, 31 Jan 2025 18:34:46 +0100
Cc: dev@dpdk.org, david.marchand@redhat.com, chenbox@nvidia.com
To: "Maxime Coquelin" <maxime.coquelin@redhat.com>
MIME-Version: 1.0
Message-ID: <11eea5-679d0980-397-2b71eb40@59612471>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?vhost=3A?= fix VDUSE devices  
 registration
User-Agent: SOGoMail 5.11.2
Content-Transfer-Encoding: quoted-printable
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

Hello Maxime,

On Friday, January 31, 2025 14:09 CET, Maxime Coquelin <maxime.coquelin=
@redhat.com> wrote:

> This patch fixes a regression in vhost=5Fdriver=5Fregister()
> causing VDUSE devices registration to fail systematically
> because the return value was initialized to -1 and not
> changed later on for this type of devices.
>=20
> Fixes: 4d2aa150769b ("vhost: remove check around mutex init")

Thanks for the heads up. I indeed committed 4d2aa150769b ("vhost: remov=
e check around mutex init"); and it contained a hunk for vhost=5Fdriver=
=5Fregister().

I applied this patch against the tip of the main; from what I saw, ther=
e is no overlap with 4d2aa150769b ("vhost: remove check around mutex in=
it").

It looks 4d2aa150769b ("vhost: remove check around mutex init") came up=
 first, because I was the last person who edited the file.

The tags should be rather these ones:

Fixes: 0adb8eccc6a6 ("vhost: add VDUSE device creation and destruction"=
)
Fixes: 78b2e3bae1af ("vhost: fix initialization")
Fixes: 64ab701c3d1e ("vhost: add vhost-user client mode")
Fixes: 8f972312b8f4 ("vhost: support vhost-user")

Does my reasoning make sense? Let me know.

:) For my understanding; now that 4d2aa150769b ("vhost: remove check ar=
ound mutex init") needs a fix, is there a way by which I could have det=
ect the regression?

Your help will be much appreciated,
Ariel

