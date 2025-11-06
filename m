Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B00DCCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 05:05:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74AA64069D;
	Thu,  6 Nov 2025 06:05:54 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 040C840687
 for <dev@dpdk.org>; Thu,  6 Nov 2025 06:05:52 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso453042b3a.2
 for <dev@dpdk.org>; Wed, 05 Nov 2025 21:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762405552; x=1763010352; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rBm8Vs//JC4ClCQR1eyKiEQtV3ub9gvOp545VpeuRCg=;
 b=Rc0zZUNuBFVALLefl/E03MegeVbYDDuZD8hWl6h8eK09V3bxrJz8NZIew2k0+8zDNn
 ae4Z6yiQq6PqSXNz6fJ5oDGzdhDy3gFsaRMDMUG4Cze5QaQdWS52IHkxz/VyRDRVQ8oV
 6WwW2OD9GbaLynmBL8TFP49loIl5wT0LV7/f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762405552; x=1763010352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rBm8Vs//JC4ClCQR1eyKiEQtV3ub9gvOp545VpeuRCg=;
 b=XvwskRA6n3RgILRTJpTmXdMy1Eg7GN1HT3xKaDCICa963CISbqOol9byqNrO+VISxA
 106rQlspPMYK2YPx2E0It53UcziLtFNrUUdlOAe/j7m2G9s8eLdjsSK8/hT0DlUlc1j2
 H7wM9plx0XuL1AqGt+Uqzs2af0c0JRQYI4YahG9uX9MOyPkwSdjooXBiYrZjOByioYgd
 aIJXuZg80uiLzhxrhHveIvKQxHtrssEGUqZKGT/IBqXdTZ01plrwFb98ZCF1tbFpsSgv
 wLyuhCjvFTvqWMwMSsLdNVc5KlechstnWyjaVBCN239FhBkAcA1wQ3wkONkNBOR91KM/
 9B5w==
X-Gm-Message-State: AOJu0Yx+QBA7obOPyogUkzA3QaOPI4xSXQ8l12Migm989OfI9Oigerry
 tY3ZXq0L/dSsxYvQKmGjnGvDT7QvCZOHtqGoBy5o7D0WrFiZ0oClTTkGS/lt/mh3VLi60ZN4cHG
 I4mX8+WdxaCr4C2S0hZeMq+dUW0SFaoW/YMk8JTwXQQ==
X-Gm-Gg: ASbGncvfiMEB3QFLUMqcVfbHTgZrapfNlkzZbBmj90K6GZz4i96T9/EDUjNsTtZoAec
 tnmJ5hHEEy3Ax9+7YIfyb2FhKyzXIGVSCy4z+yBzhXc49j+kJQdzYyIdb8XvZYRIVZypmWV+mjz
 595yKm8DVqgaqK2WDISk1ja0gY8spdsKVotV1Y+Xsw1Fj+72PVjlJniec1bo8mTl8f42umMKiyT
 2TzBZ/Y1jCh9YpBajZyJjCq/b9jUE5r1enbPLxL5uWLkmQ/D2PihorzKpB2sGtRojJF+jq8YU7y
 FezM6gYj7dE=
X-Google-Smtp-Source: AGHT+IEyu0wYSdafwjrvWaI6PMWcDdSD7etifwjfFEMn7xmBGWtJuXoaJej7GhBFHCpQ5yM4qWEmzlCsxPGhp7StknU=
X-Received: by 2002:a05:6a20:a104:b0:342:5249:83b5 with SMTP id
 adf61e73a8af0-34f839f5972mr7791413637.11.1762405551988; Wed, 05 Nov 2025
 21:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20251030125231.114295-1-paul.szczepanek@arm.com>
In-Reply-To: <20251030125231.114295-1-paul.szczepanek@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Nov 2025 00:04:44 -0500
X-Gm-Features: AWmQ_bl8nCa2nokxGb_xChpISjlkxhCdbj3UmUo1JG74YuHVereAZ6SNnwp2ADo
Message-ID: <CAJvnSUDCn_-tofdRv-NNhd+wLusZ6xEqjGGnRcLYp1raG4qTtA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: move artifact class to API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000e07b330642e604fa"
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

--000000000000e07b330642e604fa
Content-Type: text/plain; charset="UTF-8"

Tested-by: Patrick Robb <probb@iol.unh.edu>

Applied to next-dts, thanks.

--000000000000e07b330642e604fa
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Tested-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu" target="_blank">probb@iol.unh.edu</a>&gt;<div><br>Applied to next-dts, thanks.</div></div>
</div>

--000000000000e07b330642e604fa--
