Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC343C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 14:07:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99DE940274;
	Sat, 11 Jul 2026 16:07:02 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 563E24026F
 for <dev@dpdk.org>; Sat, 11 Jul 2026 16:07:01 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B293C14000DF;
 Sat, 11 Jul 2026 10:07:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sat, 11 Jul 2026 10:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783778820;
 x=1783865220; bh=rdVkMuRyrciL+4Kt7otdE7LHlZJ3v9oW7B5dhvZb18U=; b=
 bK7BqsOnDv9S80LjJb21vrj2xUQOyrgem2rtVE6Bglq1vjEJTvEkDMCEtzZAcJqV
 B5S0Uxb7Z1AOgDuU2ZSIiC3v+CKCZ7nbulO1vCZMlqECprqeAIk8c/ON5/ucD8w7
 yldI4RfwyX40zF5NGKr9PnXb9APbvNX8mD1crpzkweVhGe9ZsHKvbCEx0YvZaxkJ
 RWLkcvP7AHduYweOq1f6zFMXOnkx0pzylwxnb7zCs92GM15+ODD1UD62xaovjeEB
 iUmrVpM//iSyknQH29pepcM0MOAkCcIO9CJByjGsuDmrlJEb/gF/UsyVa9zZG6qc
 uwjdzEAWJSBnQTh5ZPS6ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783778820; x=
 1783865220; bh=rdVkMuRyrciL+4Kt7otdE7LHlZJ3v9oW7B5dhvZb18U=; b=O
 sEl85Wtwasp2lztbOLPY2vlwZEsQFpyTjhexmNWFcHA+CVDoSJmwd8YqJmwNaH3A
 VGA8TAW/ZYNUyyYD9ixmEjRPMQBUIJw1FQwK/MfWKfgV/Uuwi7/GLGXJvnG2aRdV
 LRNW96XEVewT1f9/uogvZYVmM5zj+A2LheZifPrLEbP9OYhKY81lLx/jAZaB9iPj
 jOCPtVjepQogja38Nr17wCT8j2VlCxY6C2mwcPRF2gyu4C5LeLPdgo55NgS0ptiI
 IZQEbNc2TaL2TAoyhovQ5+whW7496gzDaUuyuv1jW43iu0/0PUC9qVh8lkKsMv7k
 f7Mp0aLvYvgVl4Yo4nMHg==
X-ME-Sender: <xms:A05SapyHkxgQkTRdgLge5HEbsVUGr5-DQAxnhbThuGUIlvagxTuZyQ>
 <xme:A05SalTjLi8EMqzi26asIaYa0OHv4YTecl2240za_mxSNJtL5c8GjNa2gfKrW8GWz
 VSIdrN-mmeDVY_x9Fw6fqcEs0i5Gc8Xi6_c2Udq4k9e3Xd0HdaLvg>
X-ME-Received: <xmr:A05SaliTZyMGxOy1A0P7bSMdFO8f1FS1X3T9e6Hu-x4Ea-qTp9zFv72_jKrPJvzsbsA8LnQ_EpFB6bBWwQ>
X-ME-Proxy-Cause: dmFkZTGNtsqQchMie7XP1FLhwiztLVGPw4HcCuD9250bk7dCzCRMelGk2osMPYxJRof/pz
 A5riHSJrwb9hh9FkPtlLN4RtvEjuH+uvC0rRcwzDPzfkMBzwQAW2AiJn/jdVMWiU4pZO61
 glzgWtjyns+DPcFBvNb/Xjw2ACkjYwtYOD3eLhgt5VAn/KyeGltDnIuPbswiulOPvBHBjK
 tmS41xvwQmnGZYhpdejrwhsPPC5o4/+TuWiOfW3S5/DbdV7IkWUYdVxVRF6UTx5GSutFwZ
 552m3J+M142EV4Kcd/LAIXpBgwrYpvkYTq7O5hnRiY/5ITmPjOYv1q3J6JIAvN0zi8bAsQ
 CgQkZ1CVAmSze+29yiHjpEY6rGV7h/bqNUWbrQokqv4WOvzcgiy//w7o1Ykf3G5I4rx09/
 lzrLgyLo8uUnv8KwBgjrLxDRLgbmybuEP7IDZDtB9MaUmA66Vr/8cFy7+7SaHRfFTp/o0J
 Cib252aYzCjAC8SgDYSRxwpOOi+gpG/N8OfHff+YgX302gI6Z9stEyKbPYgJ2pureAtgor
 k2fhznau0iqBu6LQSJdM36i/a8TgAjfRUTSTbBm/O1LzeDz8d39XZLB+urjJey86KN9bc9
 qEzc0bDVGCgLWDgq+mVWWFUTiiOBmLuwvnjnFgqHEWfu2Y91IELxuEDm/qPQ
X-ME-Proxy: <xmx:A05SasmsTnnaqual8az845edCcZ8egNVTAjnphFBDBGayuMrfMIT7w>
 <xmx:A05Saov8JXTBTBzhR-H41gRywP8mK7cLxdBLCASTQ33JiMjVFjrMYA>
 <xmx:A05SaqYewvwy24SzFvofLSeDub_zykVpV_4wCAAaVbkWrLI6w77Kpw>
 <xmx:A05SaoBguLwFyum2HilKZtOxtFsSPJ05toB1MqjFSLlVkPYMLdMQSw>
 <xmx:BE5Sas08EP4E7kidQBa9aJKvq3HWnEZa7Nl5xLA-gpC091opA0f65P2L>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 10:06:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com, dev@dpdk.org,
 stephen@networkplumber.org, yangxingui@huawei.com, zhanjie9@hisilicon.com,
 fengchengwen <fengchengwen@huawei.com>,
 "Macnamara, Chris" <chris.macnamara@intel.com>
Subject: Re: [PATCH v4 0/9] power: centralize lcore ID validation
Date: Sat, 11 Jul 2026 16:06:55 +0200
Message-ID: <7JhWEHgfTSeEO7H-tOck0w@monjalon.net>
In-Reply-To: <2a191a7f-5439-407b-b2cd-44dae6ab0cbc@huawei.com>
References: <20260615073050.1996063-1-lihuisong@huawei.com>
 <2a191a7f-5439-407b-b2cd-44dae6ab0cbc@huawei.com>
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

15/06/2026 11:22, fengchengwen:
> On 6/15/2026 3:30 PM, Huisong Li wrote:
> > This series centralizes the lcore ID verification in the power cpufreq
> > framework, replacing the per-driver range checks with a common validati=
on.
> >=20
> > Background
> > ----------
> > Currently, various cpufreq drivers implement their own lcore ID checks,
> > which are limited to simple range validation against RTE_MAX_LCORE and
> > involve significant code duplication across 12+ functions per driver.
> > The checks are duplicated across all drivers =E2=80=94 any change requi=
res
> > updating 5+ drivers identically. Moreover, these checks do not verify
> > whether the lcore is actually managed by the application. So it is bett=
er
> > to verify lcore ID in cpufreq core.
> >=20
> > For cpufreq-related APIs, although service cores do not typically invoke
> > these APIs, they may operate in polling modes where power management is
> > required. To maintain compatibility with applications using service cor=
es,
> > the validation logic now explicitly accepts both ROLE_RTE and ROLE_SERV=
ICE.
> >=20
> > The usage of power QoS APIs are similar to that of cpufreq. They also c=
an
> > accepts ROLE_RTE and ROLE_SERVICE.
> >=20
> > For PMD power management APIs, the lcore must be ROLE_RTE because these
> > are used together with the data plane of ethdev PMD. Hence,
> > rte_lcore_is_enabled() is used for validation.
>=20
> LGTM
> Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.

There are other patches for the power library which require reviews.
Please all, review each other to unblock patches.


