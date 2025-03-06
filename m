Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59777C282EC
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D0F34065F;
	Thu,  6 Mar 2025 14:19:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D3B3D40430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741267186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/nO66CXvfpfQMA3tyjm9VqhamUHEAyqiAe1ZUqvsgc=;
 b=UYP7oHQCsVsPyeONnQ8XaCz8wqwTFqcUhuyWSAGj8Rxml8oAFaimBbXbvWApXJA2CFck3v
 GJri08BDeQ1LtyxZB8Eaz/QUAwI/qFny7dl6OcTsRiASMs1r6PnMB8x2fd5rnay6GUaUE3
 RKwo99rIOx6LEI3Nu9eSzDRmpl++obc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-LoraVscANqyWKSZqHQb2ow-1; Thu, 06 Mar 2025 08:19:44 -0500
X-MC-Unique: LoraVscANqyWKSZqHQb2ow-1
X-Mimecast-MFC-AGG-ID: LoraVscANqyWKSZqHQb2ow_1741267183
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30bad8f7228so3327831fa.0
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741267183; x=1741871983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/nO66CXvfpfQMA3tyjm9VqhamUHEAyqiAe1ZUqvsgc=;
 b=iN54rmjr8o6cnsvQDm77irlLUYPmJr3k1QbhUjzC7RehrePjljbubx5r7D6R8HPXH2
 LB+IMlmDg+U+fqT3ZG1tX1JJzEWt50AzdoQcNsqXapEiPFY1WqdFyTtZPv6AoUwOTIhy
 GJN1BFXuQnvf0S7KRrxTnU5Wvi/6A9INGd5keuqkG12DGtW3SsvNdqKCcXuFiUPSt709
 jPZ5EVixS1Cy5RhK+rC17mkh11VmxEGq6Azgf5BFeETGFSQuP6wCWf2OwjVTltZijVJX
 wfntmTIaTmixs1m6l2U9AidobPLzatHVKxQnEm2eJTT0S5fFhTbVGgyANvcWWiwiOa5I
 gxUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYzEyduEzbRJXiIOpFqbhazHeuZQ1cmvk4CqamSLUZKr++gsDOmiGHroh2n7+sBAeKghM=@dpdk.org
X-Gm-Message-State: AOJu0YwNw13y7P0eYL6MNbDgqlna/8ErEm1WYa9GO6PAXdkqc8hBeFHx
 Xsvn3NWFyWvsLJTSDtcihQTPqdiw5X3XduHozvpr4EA5c+KDUkl2bF6CBBRuykuVpnqL7Dn7vFv
 eYbD3OY5DLvcHxIv7BL47oZVZD53ZMFQtH+eH9mhiBas/drrEsMD9znw85MYEYSfgylffXuniW5
 zv3DPCIxTME6xWy/Q=
X-Gm-Gg: ASbGncuo9xwxS0U7UcSxtimbIpMlsPppWp9mwBDcElcFjYeRCCg711JT8262LCHeIJk
 W4eE3Hn7hvUpI7CvQ2oQlEHl0Anz0ixl98xIlitU4GwWw2nxr/y7zXI+jxm7mTzztwMVY7sleNR
 8=
X-Received: by 2002:a2e:b8c9:0:b0:308:efa4:d277 with SMTP id
 38308e7fff4ca-30bd7a507f6mr24684051fa.15.1741267183342; 
 Thu, 06 Mar 2025 05:19:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqsrEdkdHw5HmK5kH+6MKnmANwRYcqhe4d0cjualm5pwroQK6Xupm8Ud07HOGTAb5wdYsw1Hv0/kYNk/1ai9o=
X-Received: by 2002:a2e:b8c9:0:b0:308:efa4:d277 with SMTP id
 38308e7fff4ca-30bd7a507f6mr24683981fa.15.1741267182964; Thu, 06 Mar 2025
 05:19:42 -0800 (PST)
MIME-Version: 1.0
References: <1738632218-5796-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738632218-5796-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:19:28 +0100
X-Gm-Features: AQ5f1JochVsqya7mOaeoCAN4ADHti4O9lDfTiOvXuaIwBS1ScB0HHOc-VuWgsJU
Message-ID: <CAJFAV8zTAAwYHFBdhjrXL0RWX7XKHF=CWgEdithqV1xF3TuGjQ@mail.gmail.com>
Subject: Re: [PATCH] stack: occasional crash due to uninitialized variable
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Olivier Matz <olivier.matz@6wind.com>, 
 Gage Eads <gage.eads@intel.com>, dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yfy2X-hhs7mkDu35iyKFEHHl4w0zoMPH3JEBvsehlvQ_1741267183
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Feb 4, 2025 at 2:24=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Variable "success" was not being initialized and there was a code
> path where the last do/while loop in __rte_stack_lf_pop_elems
> looked at the value of this variable before it was set to any.
>
> Compiling with msvc resulted in stack_lf_autotest sometimes crashing.
>
> The fix is to initialize the variable. This same fix was applied to
> stack\rte_stack_lf_generic.h in the past but was missed here.
>
> Fixes: 7e6e609939a8 ("stack: add C11 atomic implementation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied, thanks.


--=20
David Marchand

