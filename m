Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC6FC531E1
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 21:53:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B38DB402C6;
	Thu, 19 Feb 2026 22:53:32 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 4AE7F402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 22:53:31 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-503347dea84so13877651cf.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771538010;
 x=1772142810; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q18369xYXqRdn0ZgQtDXrd8IGLUFGAiCRcbvN8JI8RY=;
 b=E2/rRoVSQFx4+e/d21+c2BUG35t0WezHFFncJulJ1S+2dO1Mb7JplxV9RQZJespC9e
 1jLwhlE6B4wDTeGJPtdhoyzeirr6qLSFq+IICm9FVSwaXXKvxDuwV/TumRkhozK7uEjH
 zT4udZFxMeaynM6FT2bMTTXPIOp32jP9i3WPFs9atP2jS5yMOEhHufloDGVbcCE5iOjx
 I0N8i4aQ3XnzNljYWkwgyAC/hs4w+WueXbG/zIzIc5x8FerazMahFKTJY1q2ByZyLfzd
 tQZI1s7EFjq5jFvreQNB05CJWSjlb4OvanH3PfWlTv/So0ky/vyTzjQ67q1BE7mdJwwk
 tplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771538010; x=1772142810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q18369xYXqRdn0ZgQtDXrd8IGLUFGAiCRcbvN8JI8RY=;
 b=q6bSD0PyN/WKEp+V1f2VM3cAHG2X4w6PhitkIY4KZ+RaPAFq3ZuslW1fIGkB/z02C9
 b2ImO/fX2hspzX+jHq2a8MKPbnB99hb7Gr2bAeoqzU+jqFglHPZehTLBjFfe3S5qoBC1
 nqpEp/pbkLvhhPlfpS+sRKQpxKyd5y25874rL2Gh3ImACfEo2A/PCbxInIzXHr3EmDHH
 4+gA9ihGJ3ra2KkD5HMpeB0dvCMRGuVPTtmesZKD9pqSEj8JUuBqlgiuTiiVfIhJ5HFS
 LVm3gpaOa8KGmSLAZmhdnwFx3YskSXymlJ8+NP2WtLNKYIZDu7YqWb2YjJXM0WqZvq48
 0haA==
X-Gm-Message-State: AOJu0Yy05gpbyjP5crL0tYAlwWrrwk1ASLwy/f/r5u9P686l8WQO5B4r
 /RDgVIHLG70RrzfP9oWlLIhNHEG/SXX87aga3b5SY1zd5C3L7qS6lcBydRsziThmavQ=
X-Gm-Gg: AZuq6aItu+o8chKN4uBQ2DUEDonAeVMEcOGTDkoF0KHadtarq5nMmHKFyEG5S2syivd
 MdXRTUm9HznFLdz/JfkxwxkFQItZMWNI6n9SzblxcKLD0EM8GRHQeJB3DyZMd63QR2j5oGs2FOC
 OnJ66EdXadT8AzGkPOwCUC9KiwDsPlnuIBEfAm5Gqy6VQWc3SH7gWzu/uDy+Lidx01I0en0vL/4
 mcNC5KDtXF0MdCVltqDCqB+FMH4Aw4BsPwuqJ5n7/3ysuOQeNrqq7no1hIQZylFxW6Dd7DffbXM
 YFevswxd6MfC151JXVtrW3VstnaDQY6j6dJNsd/MK27l+3W7Lh+eMaVHvef2QA/usxwMQb/Fibt
 L48h9yynzZwBGnMVtE0Oz7mFzfY/jJHxL/A6FTQW3QvQ8kkKDKDWn/aHTCVSYZ2B9Y0XD0zLRqf
 seglOVF9nvFOMcqqO5mc/rPWti4aMHevjT8Zs0Q4iUC7oJ6DvLEnVtyACyV2pYe+aB
X-Received: by 2002:a05:622a:1884:b0:502:9a94:2f9c with SMTP id
 d75a77b69052e-506b40012cfmr239937621cf.44.1771538010326; 
 Thu, 19 Feb 2026 13:53:30 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506847d6f55sm249150601cf.5.2026.02.19.13.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 13:53:30 -0800 (PST)
Date: Thu, 19 Feb 2026 13:53:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Selwin Sebastian <selwin.sebastian@amd.com>, Kishore
 Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Jeroen de Borst <jeroendb@google.com>, Joshua
 Washington <joshwash@google.com>, Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH v2] drivers: disable comma warnings selectively
Message-ID: <20260219135326.47236283@phoenix.local>
In-Reply-To: <20260219152302.2103018-1-bruce.richardson@intel.com>
References: <20260213151559.656837-1-bruce.richardson@intel.com>
 <20260219152302.2103018-1-bruce.richardson@intel.com>
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

On Thu, 19 Feb 2026 15:22:25 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Rather than disabling -Wcomma for all drivers, only disable it on a
> case-by-case basis for drivers that need it disabled. Use a variable to
> do so, to avoid issues with compilers like MSVC that don't support the
> -Wno-comma flag.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Queued to next-net
