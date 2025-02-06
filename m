Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58328C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 21:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BD4240EE2;
	Thu,  6 Feb 2025 22:06:01 +0100 (CET)
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
 by mails.dpdk.org (Postfix) with ESMTP id 1D2D2402BC
 for <dev@dpdk.org>; Thu,  6 Feb 2025 22:06:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1738875958; x=1770411958;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=7Kdh0Rkd/wJeEo7xxA4PfapIV65T3FpoySrrbbfqDhk=;
 b=Mj4Zf7rJ85OJ78/VXzS+HWIfsdOfu/FWU3oTv63b/qrV6IaJ/nJ27hxp
 hS1Wbmg5vHgKPTHk6eO5Bev6gE/8b646cbjs/TUgv1i4KsuyOmXdUTza5
 VuXMlmtoRyr1GtFec5N2sjULmO50S+M640cGbCVAQAz0tDYqw9t9pJJD6 0=;
X-CSE-ConnectionGUID: iCi6qKz6Sg+skVFsFq6Zzg==
X-CSE-MsgGUID: oBhFZKKvS/amnEZ3Baj7Dw==
X-IronPort-AV: E=Sophos;i="6.13,265,1732575600"; d="scan'208";a="28888153"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 06 Feb 2025 22:05:58 +0100
From: "Ariel Otilibili-Anieli" <otilibil@eurecom.fr>
In-Reply-To: <f80bf8d7-b57a-4816-b207-65bf22e436f5@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <11eea5-679d0980-397-2b71eb40@59612471>
 <f80bf8d7-b57a-4816-b207-65bf22e436f5@redhat.com>
Date: Thu, 06 Feb 2025 22:05:59 +0100
Cc: dev@dpdk.org, david.marchand@redhat.com, chenbox@nvidia.com
To: "Maxime Coquelin" <maxime.coquelin@redhat.com>
MIME-Version: 1.0
Message-ID: <786c0-67a52400-aef-318b4ec@175281925>
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

Hi Maxime,

On Wednesday, February 05, 2025 22:18 CET, Maxime Coquelin <maxime.coqu=
elin@redhat.com> wrote:

> Hi Ariel,
>=20
>=20
> Not really :)
> Without your patch, ret was assigned by the pthread=5Fmutex=5Finit() =
return,
> so always 0. With your patch, this assignment is removed so ret will
> always be -1 for VDUSE devices.
>=20
> So before your patch, VDUSE devices registration was functional, with
> your patch it breaks systematically.
>=20
> We don't want to backport my patch to LTS that aren't imapcted, so
> tagging your patch as the one introducing the regression is the right
> thing to do.

:) Gotcha; it is now clearer to me.
>=20
> > :) For my understanding; now that 4d2aa150769b ("vhost: remove chec=
k around mutex init") needs a fix, is there a way by which I could have=
 detect the regression?
>=20
> It could have been detected by testing VDUSE, that's how I noticed it=
.
> But VDUSE is still fairly recent, and it is not yet tested by the CI.
>=20
> Now that it is supported in at least Fedora without any kernel change=
,
> we should work on adding CI testing for it.
>=20
> > Your help will be much appreciated,
> > Ariel
> >=20
>=20
> Thanks for your contribution,
> Maxime

Thanks for having put some of your time into the explanation.=20

Have a good day,
Ariel
>

