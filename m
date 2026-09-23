Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF663C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 16:52:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB14B42E81;
	Wed, 23 Sep 2026 18:52:22 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 610F24027C
 for <dev@dpdk.org>; Wed, 23 Sep 2026 18:52:21 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B8FC07A0108;
 Wed, 23 Sep 2026 12:52:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 23 Sep 2026 12:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790182340;
 x=1790268740; bh=g03bDsHZeAnvkULdbDFHvsbkAZgT5/b7wHsRBQs/MNI=; b=
 tSOWP1fALoFr1zUqtS6EZhWAhp3Kub+yzZPzYNsAsCV17MJkzrV04Tpgd8LJSq9G
 oN9cGZOj6uIL9GmoAH2uwVCmQWqsR6JArsBZ8RUXEzBkE9TppNILYdSyun4VrxHN
 7o44SF6i011dlP7flWb93DMOE4EjTkSOOfk3cYdSblAQn65cXLzDdKlVn1WUEDNs
 JzOjcI/oCrdrylL0erjO/2RxKDVg/bUMbd9STtJ3I6705ENP+LncaJjEoM13wgR6
 4+GHuYhztOJIpCIpMiYml5gbxcw3XB7QgpUXZjIszyq4Lg7GHr+iDNSlBVA/tepc
 K8mlimqFiyL53RTAl/kPPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790182340; x=
 1790268740; bh=g03bDsHZeAnvkULdbDFHvsbkAZgT5/b7wHsRBQs/MNI=; b=V
 EtVUUNOPTbSxVDYwFKJdr/PClMe7+L6XvFyIgfDnR42tXL/3/dIMQEo9i1h3oOzU
 SJKLuw2DGohvSByoOpYxd8N4Dsb1TuEVzDv/6huVo+nyIwEmNr7mSQSd2xj/kEeA
 JgNmwUWsN1U/Zdqxp3358HAn8/4N+xEHfedqQKwAMsLQ3MlXHQdLwCy11ZEvr3LW
 NFWZPNcZRb1QeSO79jzPUYWr4/Io8zvlXkZtB7+Z/g+yOglkMzP/zRp65ksYqesw
 ohJ1TEJsMZmFNTK1Ues9OL3P+VfhsM4Hdy0vYyJyF1209QFpc1YpIAB/SS9rzqsu
 GsZkez3lLDJsE4XA111lA==
X-ME-Sender: <xms:wwO0akoqxEgVA_vfi1wekfibZMyuMq75TSsA9Ct6u81N7IpdFr5wIw>
 <xme:wwO0aonF9bcSIq55bAtF9fiaUOyV8hfwy08JqC8HRKC_fnf4vecpTgA-_5L8RhyKG
 FyZLDQmyXFGTBhx0BogNdL7rwhFON5VXW0CgG8A5q-h-b-RyqUU_Oj6>
X-ME-Received: <xmr:wwO0arhy2wIfwUVdoA9VIJafviAIhBHeHbidIqLqKYt4NmlyV9bWx9DxV6bSaNGYPG9qMvZBVH7ZFW2xtKVQP0Y>
X-ME-Proxy-Cause: dmFkZTE9cj5qesljt4oa7EuOXGksk2g1Q/eoWl4WZzXKOozYmrd3wKWqcnZT8eY5T4VQtk
 JGtN8ui2MBfsDd8Oss0HvNF3pe0KTJwXxBb55OWSC4+R5nTSY+MoTP6lt3xIUfpzkx1LoN
 3UUZSHIfaqAncIlTDDO7XX/9OdqOxFdTzAm4OEn7YzoJu2CgdpWelGV3j+ncs3Atm9iJzT
 UBXpj3LuBYqKjk1piTHyYhKAfzrVQ3D1Z4t98V4zdwTJucUolkmY440ltkcZyxUO+ndHEZ
 iIoExDuJ+VNVUbRYoD0vOHQ38pyJI9rz5ppDbIQ8aVjumFoAL7/x57OP+6myurmtRLgTMi
 tJKxp4aJmgzE6b8OZbQOQ7xkWis3OptWytZLrm/IQ8yUwZLEiFdsmD6Grg0cGHljotIF0k
 h6noaozK43mv13afvoFRj6s63Ldll2Bu9PduW30IgvacWz12mPD/8MGT20ghpGsFazZKcc
 0Zo390EwIAguZE/xaGYPdLg/eMPL2xhsXoVfktOkomTUuOR6jJrRFMtrH6NMkqjo9QbknU
 9o4Q7eLD/43o5DhurPBGLe2C/xS+FYW1JZcNPfLK+U9eRe5bUsnRzh+ZxtI3L9CWv0FFrG
 tJq7xTQxCHAzyMLjvDfAsXXhfUYYiCkkLl8z9MLWCfH44OTQFx1COUGLZzxQ
X-ME-Proxy: <xmx:wwO0ageD5PpzPkDjBrf-pZaUU7oP82w5wra5Mwitga39XDFbnuohXQ>
 <xmx:wwO0ariDZeEV_cwWJTqo6Mw8glah5YutJKqP_xIYsfm7RuGnU5yZtQ>
 <xmx:wwO0aow0ppD3cZbtSzS6AsJMMlAkvOHwUWdMV6XodaKDn0hPwDPkKQ>
 <xmx:wwO0anNGOlJk8mlAntRUZsGdoNvGsQynS1P6brb-Y6d6m_zQphBsNQ>
 <xmx:xAO0aun1fioLmF-0p06l8aSwv2No4fCZSllhC2Fvk1DMQJwSWGB6A-kg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 12:52:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vipin Varghese <vipin.varghese@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v4] eal/x86: fix memcpy alignment mask definition
Date: Wed, 23 Sep 2026 18:52:17 +0200
Message-ID: <AsJq5ADXSsikHxOP9jPwbg@monjalon.net>
In-Reply-To: <71bcbf4789914a059ccfd11758d72bb7@huawei.com>
References: <20260904092028.856816-1-mb@smartsharesystems.com>
 <20260904113433.857609-1-mb@smartsharesystems.com>
 <71bcbf4789914a059ccfd11758d72bb7@huawei.com>
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

> > An alignment mask (ALIGNMENT_MASK) is temporarily defined for internal
> > purposes, but it is publicly exposed when including the header file,
> > potentially colliding with existing definitions with the same name.
> > Fixed this potential issue by adding the RTE_MEMCPY_ prefix to the
> > definition.
> >=20
> > Furthermore, the superfluous function declaration at the top of the file
> > was removed, and its description was moved to the function definition,
> > to improve search results with source code browsers.
> >=20
> > Also, changed "!(addrs & MASK)" to "(addrs & MASK) =3D=3D 0" to follow =
DPDK
> > coding style.
> >=20
> > None of these changes should have any practical effect.
> >=20
> > Fixes: f5472703c0bd ("eal: optimize aligned memcpy on x86")
> >=20
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


