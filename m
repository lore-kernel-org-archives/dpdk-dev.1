Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C513CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 16:28:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CE814065B;
	Mon, 18 May 2026 18:28:45 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 6AE4E402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 18:28:43 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1334825de43so2249813c88.0
 for <dev@dpdk.org>; Mon, 18 May 2026 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779121722;
 x=1779726522; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyC5+dtKORI336Wuc5rwh9vaK2UHCiB3Dy3WEQjUdQo=;
 b=qNPRzECgCFZE5U6jWgGYFdxP4/0qFGL+cKYw0OYCxeE7KfaeM4unn3Gdny9qhXYxNP
 wUckdM38ktj/dJn7fBNxA5vW2VslVJlpxE6xY4aak3bQI3QiGyNUzTnG/2RAFuzyIsL+
 LmTbKpUoic2E1DSmk38OQP4X2IY5LSXfkD9nxuqb2wDp4gS0K+0jQa3kGDP4wF1aCRqX
 9scoC4GgH0haLW1HqUycOB9sPo4NwWy0wPZwU+tkgBgeOYpGOQyHmCeVqx/Cq03g8qK4
 Teaaf4BwUGYtB4akNQ1wbNbzWK/4rkglNb8o2ZbH0YXLT5Q7L4VmM5vdJLJuJl8l4Zge
 /6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779121722; x=1779726522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oyC5+dtKORI336Wuc5rwh9vaK2UHCiB3Dy3WEQjUdQo=;
 b=pL2ZpdgVmlfcvsiFgVe8FmJ1x3iAJyveQRgAk8WBIm3IL4SpVKFt/ExU577z7W5TFt
 mL1uXRRlpkNUJ2NXcEwnG849gxr1sx2AwgHs9gVLu3fanxfMLoeVCCBM8OvUEiOtwb5T
 lE6In5AvaGULy/qVkegzB3LQCYdaP5Rp7MmPTDim2WUhF8jZhRZ0QiV15AjnelksW+T4
 y/PzD68Ify5bKfx1GGCWXpNfUau49qqaQKRh2OqXIeDy1AD398NcWlOV61PKq/Gkub5s
 OIJGvNqsWQjjoiEtFAQrbpUs7VeqHKJmkFw2UQr+6EBMh9atn5eS+LgHV6To4sBQEVEt
 x57w==
X-Gm-Message-State: AOJu0YzCZ6zA2UN+BdvI8vmY3WcKD45xrA9JDZSsWncr0mzkQkYa6y5F
 ga8UQxcyrqBvZwLvN42ZPEmznwvWp/Ya/+WrHWYQm77vEjkvhl5lCEg5KdM1ccpGKtg=
X-Gm-Gg: Acq92OEgcMRvKavooMP5GvHI6Jd6kmNv6e4skQ9KbdOItvPtCPVHzKaBMiVPLG0POZE
 slFx7W9lnoi5ASftNJ76/Jaxs38um2q+4fQzmgINFONM0Cv1/V25w2iVw6d6gm6zCjSqQW6etNv
 lcysgZ/qc5W0o8IK6NBfSIfsaCq1b1EQrG0ytS3B9rhiSbmpQ/a5aow3KCI/9VAj78hrL310UOy
 3g8sbEfGzheNbIsC1nq/YD/wkpuYpC1IPG9rJ/2JWoErt0pczbv4653izFcvQ/aE1v7c3nET1Av
 y5IXFW8nT3kEUxPrhQXOgXA/sHaOSjE9S2nZdBVCGYmzg8V0hVJibFQgeab3IDB9F4n7ubGUai+
 vm1/FVBjrNLsC5ga42J5RccSTXczgyRkn9cnEphrzqiG0rFP6oO+/RyDFVmwDtmTcYACtjIpVTq
 n/eAR7IiqIVyD2JgV6oQlv3ijtN7egVRuQVqI=
X-Received: by 2002:a05:7300:6c05:b0:2c5:60d0:702e with SMTP id
 5a478bee46e88-30398655301mr7140442eec.18.1779121722334; 
 Mon, 18 May 2026 09:28:42 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcc464sm15032740eec.14.2026.05.18.09.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:28:42 -0700 (PDT)
Date: Mon, 18 May 2026 09:28:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Robin Jarry <rjarry@redhat.com>,
 stable@dpdk.org
Subject: Re: [PATCH v2 1/2] spinlock: remove volatile qualifier
Message-ID: <20260518092837.14765b82@phoenix.local>
In-Reply-To: <20260518150819.3332628-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260518150819.3332628-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 18 May 2026 17:07:35 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> When compiling with C++20 standard requirement (default in GCC 16),
> the increment and decrement of volatile variables are rejected:
> 
> rte_spinlock.h:241:14: error:
> 	'++' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:252:21: error:
> 	'--' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:278:14: error:
> 	'++' expression of 'volatile'-qualified type is deprecated
> 
> The count field of rte_spinlock_recursive_t
> does not need the volatile qualifier
> because it is only accessed by the thread holding the lock,
> which already provides the necessary memory ordering.
> 
> The user field can be accessed outside of the lock,
> so it must handled as a C11 atomic variable.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

I would also suggest renaming 'user' to 'owner' to follow common
practice in other places. It also provides an intentional API
break if somebody is misguided enough to do direct access to the
structure field.
