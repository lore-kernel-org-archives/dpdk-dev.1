Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0DDCD3436
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:49:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF255402E8;
	Thu,  7 May 2026 04:49:52 +0200 (CEST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47]) by mails.dpdk.org (Postfix) with ESMTP id A0C5C40265
 for <dev@dpdk.org>; Thu,  7 May 2026 04:49:51 +0200 (CEST)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-43034c0fd27so119541fac.1
 for <dev@dpdk.org>; Wed, 06 May 2026 19:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778122191;
 x=1778726991; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iz9JGo7NFUVRdcvUZwE59LFxGpIb/vX53VTem/AibyQ=;
 b=QzqFzHuSAZjJzZqJm5Xe1lpRjkI06rK6Cauh+3SOFV6xmd/74xuZHNHgO4H7QjuftF
 lgLgw8c0QtLEBvZqJWjlX/zdFJ/o/yIW3ShvTRmkbe+j36eJ69jJw9oWIWDtAXchSaTn
 8yg811MMgPoqmqertT8tf+O/r4hlWHFcqGmkV3aCe5IQuAva9aBrjg1sihyjX5ijH0SX
 8CxV0huiy8kCazT/QDU42py+5m/zjTzWKBksliN29d0590NOBdKtOcNFEoi2HNG76001
 2sEYI5TkdR09v60WcvrljfGzfLudORuwVEz7ZO4VDqv+qpkhIduC6MOO/Y+rLy84rBNh
 e37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778122191; x=1778726991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iz9JGo7NFUVRdcvUZwE59LFxGpIb/vX53VTem/AibyQ=;
 b=TLLO37NY2iTLOyLl8mr2eFGvOePU7WZAHIe+JiOYSG+4VY6bva2ilhhWf2QHH8AK46
 L80AKKod9j9rGgOy/ug+nj1jeLb2iiNKCDELd8TrbVuDBf1szEMarwxIex4XB3Q0CI6a
 AV7G9wtCb2yufkGGTomn3eyhuygVf4edsf9vLCVZE5MuNxJO6jDLO+ShXBLW9sbWRHlD
 FDy8mVc+60U9oSm3cjia00OnM8IhAWLKXZJMlTdbYlpNF9EiSDv1Q7tR0EqHaOUXWVJb
 JJMjwQfmqlWueNH5NTK7En5TTBQfaTTHWkJAXMZP4KjCqUUOCDed3QTo0NSCRl2aBlXT
 46Eg==
X-Gm-Message-State: AOJu0Yw2yOzQz3GJsBxcW6cc/AO4fPreUtVziCuslqDzQrUDLSJ7cXEe
 8RXc9YDTI+O33LGBVlHNnK75rp4CkCa/hx1ArxJWNj8nVbsj9oh/dlbQeO5xCP/9E8I=
X-Gm-Gg: AeBDiet2HdLbLb58AYlb6IB09rDtOOqXgd/Y+oiIfTB8niIrBUxdmdKi3zaK5AR1SOB
 sWB3e7vG/L3uvvbqLwxHIFscCg6aA1y7i1AIIGhrMqRaGWUihfa2In1RjcRfAwoL/0OzgGQmgE2
 Io1szB+WQk/CBliTWOuTGNgMxmZmiDSb+cUhadJ3pl8JdI7A9Flmdab2l5k/mKBN0x33qP4zQjA
 8ADnSI24198FIfR0KsIMCC1dURceIcmkTlgSPNHx/ST57SG5cG2IxT8zil8MgdNmEV4JfmL8wWu
 93/PS1fKoO04J+ZwNst29MbN+Qf9Gi3tIjEmJP5M/KKk8W7BJTjLFcxBDNucIWnqnepTbcPsZ+H
 g4P8WrEd9FNsDRj/rX09EoW6zv74fYfmaeVHSyPQ3QK6aW/AXtLmQjkQtLvDacacwvS0DaMeV/p
 84G43NcI8TazOaQd/6Ss4CDX6gbtIaPdP8En4/FVmDyYnzta5xFOa+RHYV
X-Received: by 2002:a05:6870:1652:b0:42f:f092:bad6 with SMTP id
 586e51a60fabf-434f63f2c12mr3700557fac.23.1778122190814; 
 Wed, 06 May 2026 19:49:50 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454dd93fcsm19181806fac.18.2026.05.06.19.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:49:50 -0700 (PDT)
Date: Wed, 6 May 2026 19:49:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org
Subject: Re: [PATCH v2 1/7] net/netvsc: retry VF hotplug indefinitely until
 PCI device disappears
Message-ID: <20260506194948.2508fa6b@phoenix.local>
In-Reply-To: <20260506020529.281654-1-longli@microsoft.com>
References: <20260506020529.281654-1-longli@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue,  5 May 2026 19:05:22 -0700
Long Li <longli@microsoft.com> wrote:

> After PCI rescan on Azure, the MANA kernel driver can take over 100
> seconds to probe and create the /sys/bus/pci/devices/<dev>/net directory.
> The previous fixed retry limit (NETVSC_MAX_HOTADD_RETRY=3D10, ~12 seconds)
> was insufficient, causing VF re-attach to fail with 'Failed to parse PCI
> device' on systems with slow MANA driver initialization.
>=20
> Replace the fixed retry limit with an indefinite retry that only gives up
> when the PCI device itself disappears from sysfs. This is safe because:
>=20
> - The retry uses rte_eal_alarm callbacks which are serialized on the EAL
>   interrupt thread, preventing races with VF remove or device close paths.
> - Device close (eth_hn_dev_uninit) explicitly cancels all pending hotplug
>   alarms via rte_eal_alarm_cancel and frees the context.
> - If the PCI device is removed while retrying, access() detects the
>   missing sysfs path and stops immediately.
>=20
> A periodic NOTICE log every 30 retries (~30s) provides visibility into
> long waits without flooding the log at DEBUG level.
>=20
> Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
> Cc: stable@dpdk.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
Better but still seeing AI review warnings.

Reviewed the v2 7-patch series against upstream drivers/net/netvsc/. Patche=
s 1, 2, 3, and 5 are clean. Findings on the rest:
Patch 4 =E2=80=94 the new "retry loop exiting" NOTICE fires on every termin=
ation including the success path, producing a noise alert on every successf=
ul VF re-attach.
Patch 6 =E2=80=94 two warnings: (a) reaching directly into vf_dev->dev_ops-=
>stats_get works only because eth_stats_qstats_get() already memset the buf=
fers before invoking netvsc's callback, an undocumented dependency on the c=
aller; (b) the else fallback to rte_eth_stats_get() is dead code =E2=80=94 =
it returns -ENOTSUP for the same reason as the direct call.
Patch 7 =E2=80=94 the recovering and recovery_success callbacks acquire vf_=
lock directly from event-callback context, departing from the existing INTR=
_RMV pattern that defers work via rte_eal_alarm_set precisely to avoid cros=
s-driver lock-order assumptions. The unlocked vf_attached read in recovery_=
failed is a benign race that can be simplified by dropping the guard.
