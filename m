Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1757CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 08:54:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E794440297;
	Thu, 30 Oct 2025 09:54:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A230F4027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 09:54:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761814455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBI4x5BReo8nvO8FR20VWTZFHranNbvcsFky7HuKjBo=;
 b=R/9qXPDCf1mFedoZopfVB8zLLapI6D0CpBdHq+q/JdtAEaxwwe55ISrw6PEhc5GiYpo8XP
 MBtRUxejPuIwcj8J3t3YRYhN2IZnl1/qjEAiGcHWASemmvyEvD8a3DVm0Bivt8p0rxm2Pj
 57WzHH6dZTZNEF5lIH8LAUe5Y9cjGHI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-cN8W7gkJMKyrucXYA9GrdA-1; Thu, 30 Oct 2025 04:54:13 -0400
X-MC-Unique: cN8W7gkJMKyrucXYA9GrdA-1
X-Mimecast-MFC-AGG-ID: cN8W7gkJMKyrucXYA9GrdA_1761814452
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-378ccb2cd05so2920251fa.0
 for <dev@dpdk.org>; Thu, 30 Oct 2025 01:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761814452; x=1762419252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jBI4x5BReo8nvO8FR20VWTZFHranNbvcsFky7HuKjBo=;
 b=QAhIf9xdWCDxJTyplMJBhM9fAW02Jssz44mewYFgjqjzCnOA8fMC1MGHrp+FnM4lDw
 9v3jUNUsIwhV8J2gwl0pfdOIL+cuzysQ86JB6XqpldgmpVatMtXGXqpLqIbfmM/EDH+5
 TeCz/nX88Q+K6iNhbWb7dWi3X4YLw8UfnJBnbiRzF92Kb7uxq/vWNezG5uMqccG/QGpD
 rtiUtZ7kuU4skL7bKcX8TfC4GCmeRQMMA67AwZ0KO3J1Z8jReEylKv/XcReQ46KDshkR
 +CQdESovORpzgrwtbkK7CT+ZbwmzgIvLEbyeQojmAIMwQvcvq2UIIYzmyQ+T0MYFr2a6
 vN5Q==
X-Gm-Message-State: AOJu0YxUzz8vDOcIa6JSyZHnPpkc0O5KncE6cZYKnhYqbrgczWHKOtmo
 woBbsZcxgyZrQm/dCD9W5LocaBJwwBy7kzVvo6A8eT1+LwIQyLWU1rRpxSKHz6USQwP9l/+fbgq
 0lHDHwIaf/wHkeJUkbmB0WI4bUWFKVHTzioAc83Qk3Qd2lj8l9dTyRPJv8+rCxUH51hdcHpMruy
 Szzflv8yAkvxrWSP1SKKQ=
X-Gm-Gg: ASbGncuTh1mEaph5jp2c8xGgmhglhrF8498khkFNrsBxfQvyEN/FyHmqrL2zKbwNtxp
 P55Pf9iEZsXEhVg41rjkqTr3Kjq5VkfUX/vF+Y4cLB326HMmXS/MlB6QVyWVLG+k03FQLYtoBCo
 V1OASKixfN1rBYLqcbS4FFCGstFAoAEXtpVRSyshA+/K9iIJ6ifGANYBtpRw==
X-Received: by 2002:a2e:b894:0:b0:36b:ce19:d853 with SMTP id
 38308e7fff4ca-37a05378dcamr19051881fa.45.1761814452107; 
 Thu, 30 Oct 2025 01:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs3guIQQw3/PtVMFdLy6CtIQAxPsvk+eZ+/9Pgaxb2Il21mn7PNBYhX/oQ3zYNSRJBt/mQn1umDtBNx1yy7nk=
X-Received: by 2002:a2e:b894:0:b0:36b:ce19:d853 with SMTP id
 38308e7fff4ca-37a05378dcamr19051811fa.45.1761814451666; Thu, 30 Oct 2025
 01:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <7e4985db2bbf29515f8cd6a4ab510d71f8a636a3.1761299581.git.anatoly.burakov@intel.com>
 <05ecc81aefbbe2073416c0e78aed926ec9ad54b5.1761299581.git.anatoly.burakov@intel.com>
In-Reply-To: <05ecc81aefbbe2073416c0e78aed926ec9ad54b5.1761299581.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 30 Oct 2025 09:54:00 +0100
X-Gm-Features: AWmQ_bl4HBsjBR5ubryEsRIyYLzvaeW56Tjv6c82XY3Jgq6ozauGk8_EpkMijHM
Message-ID: <CAJFAV8wM7HE_WRPO0d4D1Ve5BLwfLQ=GW5iNpNQQpnaDSrghNw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] bus/cdx: fix incorrect device release on error
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qZbsCdbuUDHTF7YiAH7T-ArELGxdIctI8fNmKOhm5vw_1761814452
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

On Fri, 24 Oct 2025 at 11:53, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> The variable cdx_addr is a stack-allocated zero-initialized char array, but
> it is never used anywhere except in an error handler to stand it as a
> device bus address for a VFIO device release call. This is incorrect, as it
> should have been actual device address, so fix the code to reflect that.
>
> Fixes: 45ef232af515 ("bus/cdx: introduce AMD CDX bus")
> Cc: nipun.gupta@amd.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Reviews on this series please.


-- 
David Marchand

