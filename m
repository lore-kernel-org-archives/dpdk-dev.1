Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD742CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13DBC402C6;
	Tue,  9 Jun 2026 12:32:28 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 8CB1B402BE
 for <dev@dpdk.org>; Tue,  9 Jun 2026 12:32:26 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id EAB38EC01FA;
 Tue,  9 Jun 2026 06:32:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 06:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781001145;
 x=1781087545; bh=st1yudHkdYEmT5ZqFeOdihg7RWekkGB6N8HlXGUNQ0Y=; b=
 I6buLgLdy3zlMsXq+MxlwrRpfwkpPkqDRXDByj2blbJ1b5ovkyA08tYfo8W9jG54
 K5Sw4f9DkWv1/fAoXFNqCfuKr6OHKucP9L69oDA+pgaJT3kVH+D9XeautVWj8fPn
 cRojlj93tw4ULKvxbz59uLPaTlYj3cKKAGYpSGJQqarFXpxqGMGfmtylU4OpB4+H
 jZ4weppdybzuitygjSpLxcJHHN9bw4PGgNmAlcWvQ5PjANiBInBXFiG5kCEEG5aq
 v0oYFHNaCFSVtE90vHtr3G+CFBOg6SJ36BGRd9sil88fMhYXZAloRbiTPr5kYNO6
 davjBAiAcVBG9MOwxSdkFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781001145; x=
 1781087545; bh=st1yudHkdYEmT5ZqFeOdihg7RWekkGB6N8HlXGUNQ0Y=; b=b
 7eD24YDRo8qsQG8UspoUoC3JUB96PX5lHvp6Vxoaxbh8kydccrOTw9Ptv7ApB3Hx
 bTQrIvdK4Uzm1zzObi0Qtw72jAxmlzu53EIZylEgbLYEOkIyDTnz6yn0PeIFhcdw
 WaRKY6FylCvNF4phS2JG6CRsd8rac8ukVZvIr/xSNyvBQMMbEIh7cHqwaGHJxGd4
 TiQVp6UhLEWzKiCvD26eAuwSGTj5PzsJJACgBjTHUNL+ihdXi1Es/RadAbJEh1fN
 KC1esrRuagxpO4BT0O5OcSMB7wx1mKAw7k8/DqZUejGFm0qO674BpVW2+hVx+LAm
 +CV7h4pAEJPhP4TtYZexA==
X-ME-Sender: <xms:uesnarulktV3i7OF-1mm795BAhUGa0z-e1VGJdh3hkKemsJJ6QHciw>
 <xme:uesnalbstqYdFiymcsrEZnt_nH-8Oo-9SEpYc_8UTEOZEOpCoDUyuBTwPEFL0AEW3
 DuqF5jahoddDgYFRWip5WwRbZoOO88ZlKi3atXM6RXOu8mF2vPeDg>
X-ME-Received: <xmr:uesnaqUsuR2TOIkSan5ETvCwTJavRjggK8SV9vnoLvgXJqmYurNXPHQ_oet2kbvet6x6aoAUUvG9_ubhDT4ZPIOvGw>
X-ME-Proxy-Cause: dmFkZTGc1e+KUozDJU7AdYZ4ZDrHEcQv/dWZiUpXcDO0+nbL6b3vPO+4wN3YGe5Y4+qQ7b
 FtVrmkE1jW22QVJvsf/XjTtzNR883EEceUEoHxeYPp5QBgu0ZxiLo17bwL9TQUd00TYpys
 EFRLyfs5qRg2PtfnUUrJ7lreKiq9IxmKpdRvfvySL5Pc/Y5K8zISm5rJK5WAJI5o1mxAk/
 3CRpIQ1S0wtmKOUSSdfIhysZym6gVL0Rh7PFkA5BtdfJce1jNI14B9+h3O1s+ssaCf+B5B
 IrketqrGAEa5pVyG4Xa74Vpolq8TglpSwQ/3HttEiHKIn85UgM8hwA2V2xkq4bmkLOPUXl
 ie57S4xqRaZMUPmogAqsZbqMeCLJH+5+VTo9+3YbVi7abwEX2U/P/sbYtGmNmlYa4uIWsO
 iKxnh/Up3DHPNyPrJehhdTKkQRW/l+sIenij0iUAyWruTlNS3SIRw5iT9nkMzNhayoUxbU
 veqQ8/mPtpTvFBsJ1Dmbz79UxqgKz8eXhkAt7IBa67sZd9fOLg6aOxYHgA6rWuHK6KS1Lu
 l+kenm8jdM9m1MuQofnrKYZ5G+KY99xA2FxONPiUsUTK7c4SONtiCYB7kStyH2ua7TuuH7
 EnPhWjuyXPew04DQdedDAieU7LZWthjomwzkiT9bInoO68zBAt3imbNzGIkw
X-ME-Proxy: <xmx:uesnaqSBgTvZtLBGD9H5hl_hwC9pvLHoqiqoB7fgSkq-JBEdWc4DHw>
 <xmx:uesnaoPlkLQ8hrJ58CRKs5IX5NIR_YivwZHUWlVcH86-3KNfwynVUg>
 <xmx:uesnaoTaliJ-omBV3fGiMAiTpIK-ZCgqc3tv8epcXQJbphKxspoRNA>
 <xmx:uesnamhxs5IrYp0DgDEzfDya_Hi5pFNnrOpEmD98HNZJlC8cuTIftw>
 <xmx:uesnagu3_865iklDP_BWm5IlgQWl8nrOG3t3Nltxip42oLMqQ6xbErzK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 06:32:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com
Subject: Re: [PATCH v8 0/4] IEEE 1588 PTP v2 protocol support in lib/net
Date: Tue, 09 Jun 2026 12:32:22 +0200
Message-ID: <g4tl9WJYRZa-tMNY51JvnQ@monjalon.net>
In-Reply-To: <20260509232551.2844201-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260509232551.2844201-1-rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

> Rajesh Kumar (4):
>   lib/net: add IEEE 1588 PTP v2 protocol header definitions
>   examples/ptp_tap_relay_sw: add PTP software transparent clock relay
>   doc: update release notes for PTP protocol library
>   examples/ptpclient: use shared PTP library definitions

Squashed in 2 atomic commits (lib and new example), thanks.


