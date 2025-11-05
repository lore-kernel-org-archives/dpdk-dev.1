Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C65CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 13:39:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D70FB40696;
	Wed,  5 Nov 2025 14:39:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7F45D4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 14:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762349942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyLX/or7JPGGwCWntq7hyUIkGCzVNBDgmJK3O1UqZGY=;
 b=JLTARMudY2PB0zgIp8y21jeTj1UakDv5qNKyZy94yNb1TkFl2KzyeJGAb110goQIpXUVrP
 vviecaGeJyzoPcbsholkvJChf4o9H9BX5RX6X2MQjGMoSfU24Lgmk12/9yoP3hSGa3D7HM
 J6hIi6Yig9fC2E56CNJIKQW/B8s/Lgw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-1CflcWbyNxSNO2XZaIaXMA-1; Wed, 05 Nov 2025 08:38:58 -0500
X-MC-Unique: 1CflcWbyNxSNO2XZaIaXMA-1
X-Mimecast-MFC-AGG-ID: 1CflcWbyNxSNO2XZaIaXMA_1762349937
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-378dd2050b9so53844321fa.2
 for <dev@dpdk.org>; Wed, 05 Nov 2025 05:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762349937; x=1762954737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UyLX/or7JPGGwCWntq7hyUIkGCzVNBDgmJK3O1UqZGY=;
 b=s1XHKa0VMADZZpZg9hy09Skr73ClwvNH3AoS7YtZZ9WrtQSRSsTVBla7AtU2twxE2O
 RbdtsdfcEIpUAVcx6R5PnOs6iVIzt4GdbBo1JuspCbFIJHTq5axRgEe+sJwyzB1th2xc
 /7AW3RWXrOaTJ7SPB560dx2JWNBWQ8I5OwPR74ymdLCmy8I/HAhU/jvD6301adX2vzjy
 HyR+AC24gXcIaPckjUhcT6PSPB0a6XICNZm0PpG5/iEZw96MxcEOYlLF28OVPRAsnrO4
 vkQnn/X05hua7WfgnYrGp24w/0rJ+78xw+KXyVc3a7xrAM5p7M1KxlIT2itJfv3TMGMO
 3b6w==
X-Gm-Message-State: AOJu0YxnDbXxeXWDCZM+VxiOYnWftMNCfzZcJW7loxGGIMFcMPWIYOBk
 bQnpBSKrPd56krSQAlefk4DbVsbyf3kvNAlgRTIhUMDGR1gn9b0KpLzbDfyAjAZLNeXW4Wsdboi
 XOgwbBifknPRCBeZ21frBVu1o9VKLNOxJAawep6KUqekqQaSGCqTUQQJFNBvOj5GB88yC8dcHKd
 UWdEDCrZHBGxfjUb9XJkA=
X-Gm-Gg: ASbGncs55LNYyRcui9KNtED+FN8F8tLr7yDditOWOKWZT9+1KwzhOOutPggfZ/5WzBv
 eRKvv9BmVZh6+FFKJoL4nqae3UoK1GmXW1NqqGi5XMfALlsTJBLIFMegj7oJwtuhNNbbmQbuXMt
 EXUAZB2SsPkMEYxiDyubS39VNilTlPFuy5bxP+d80osgY2UtJ3mGOo9aR+7w==
X-Received: by 2002:a05:6512:691:b0:594:364b:821a with SMTP id
 2adb3069b0e04-5943d800dc7mr1185015e87.52.1762349937318; 
 Wed, 05 Nov 2025 05:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3TX7j/z28L59PD7oUOS/6Ot5coMDkiw9Bd48rV8I/6mjpZJmPOZwjnSN2uFHqNibG+/gfGTG9BKED7JcC25M=
X-Received: by 2002:a05:6512:691:b0:594:364b:821a with SMTP id
 2adb3069b0e04-5943d800dc7mr1185002e87.52.1762349936850; Wed, 05 Nov 2025
 05:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Nov 2025 14:38:44 +0100
X-Gm-Features: AWmQ_blT41biEZ51DBXPxu7X76N-pblbHtb74stZyAIjfSUTBJ0nvCg9LlMpNag
Message-ID: <CAJFAV8xDK1Ub_1NWHRErMXsM1Hp4_OFnguoTcdMNDVXoehDr8w@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] lib/pmu: cleanups and trace integration
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: dev@dpdk.org, Ruifeng.Wang@arm.com, bruce.richardson@intel.com, 
 jerinj@marvell.com, konstantin.v.ananyev@yandex.ru, 
 mattias.ronnblom@ericsson.com, mb@smartsharesystems.com, 
 roretzla@linux.microsoft.com, stephen@networkplumber.org, thomas@monjalon.net, 
 zhoumin@loongson.cn, wathsala.vithanage@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i6dVEnN_A7Cwph-GJlipZfMGxqbPZL5WRDW5nPOd2uk_1762349937
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On Fri, 24 Oct 2025 at 07:49, Tomasz Duszynski <tduszynski@marvell.com> wrote:
>
> This series does some cleanup and refactoring around the rc1 code like: trimming unused headers,
> switching to callbacks for per-arch handling, and adding trace support. It also re-enables existing
> base test to help catch reported issues on some architectures.
>
> v11:
> - rebase series
> - hide calls to experimental syms in inline helpers
> v10:
> - fix build without ALLOW_EXPERIMENTAL_API
> - move rte_pmu_tread_read() registration to avoid MSVC linker issues
> v9:
> - properly rebase patch integrating pmu and trace
> v8:
> - export __rte_pmu_trace_read from library itself to avoid build issues
>   with msvc linker
> v7:
> - change test return value
> v6:
> - add more logs to functional test
> - skip test in case of setup failure, user must make sure
>   system is properly configured to get valid results
> v5:
> - add missing patch that quiesces chincs check
> v4:
> - change fast test so that it won't fail on misconfigured system
> - fix compilation on windows
> v3:
> - do not export __rte_pmu_trace_read because that breaks compilation
>   on windows - script generating map files does not handle conditional
>   compilation
> - skip testing if paranoia is at wrong level
> v2:
> - explicitly check against NULL
> - make pmu lib optional by checking if dpdk config has RTE_LIB_PMU
>

Strange output in the cover letter.

Shortlog shows 10 patches:
> Tomasz Duszynski (10):

Followed by 8 lines:
>   trace: change scope of conditional block
>   lib/pmu: export only necessary arch headers
>   lib/pmu: reimplement per-arch ops as callbacks
>   lib/pmu: do not try enabling perf counter access on arm64
>   lib/pmu: use build system defined RTE_LIB_PMU macro
>   test/pmu: enable test
>   trace: add PMU
>   lib/pmu: fix out-of-bound access

But the series has 9 patches.

In any case,
- patch 2 "trace: change scope of conditional block" is unneeded, I
see nothing wrong with current code. I tried stopping at various
points of the series, no build issue,
- patch 7 has a comment from Morten,
- patch 8 has comments from me,
- patch 9 is vague, what is this about? Fixing coverity or some static
analysis tool bug report?

I applied the rest of the series, as other patches look valid fixes / cleanups.


-- 
David Marchand

