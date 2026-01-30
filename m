Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D454CE6BF33
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 18:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B4BD402AF;
	Fri, 30 Jan 2026 19:15:14 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E19E94025F
 for <dev@dpdk.org>; Fri, 30 Jan 2026 19:15:12 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so22567675e9.3
 for <dev@dpdk.org>; Fri, 30 Jan 2026 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769796912;
 x=1770401712; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYD0YGgJS2VZ3RrDF9oeM2X5iPzHLFRd+g/YwePRuYk=;
 b=KpVY3GqUmSym+hRRutr+x3x3BeiRhCjfpwhdvGy0XxnUbx/oq7pZBhA2DYp9ExxLO7
 INi3fE9hhlD8GAfbX3pgve7ikxzgjgJpyPNlxKS4bOaBLLKMpasReuh6rxRhYQhPy9CS
 6LHEuYWUcHHFiej8jf4GIe3LtItAMob5hr0XkTrfScmMhVUBD4k4wamQpd3L1S+Fz0o5
 CkpxhpOEps6g9NHI6S6VKRCBfGlhMpPUJ2d6gFND3kKJv8x8PT8QxzcltaCzf0r+Ai2L
 OYggKzSEMhrqMlxktXvsF6baPvxlsBOMsqKxhgdRaZ8jsgQrS4ComtWUqVnvyCRzY6mU
 6b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769796912; x=1770401712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gYD0YGgJS2VZ3RrDF9oeM2X5iPzHLFRd+g/YwePRuYk=;
 b=ZsPRabhQALXrPO+Kajj2RP7jF53jFT5gxGegNfWXUn3inQPmi7WsIR8gzo+5rRMqrv
 37MBmE+EH9oMjvzuZy/93vKokanOfs1Rd+1yxxu4SQdvvf/UQn3+LNRdaoY61Rva4VLc
 7ZypPnnauR4x0e/ZZ/xiYpKgONfADLSPU+z5JorLkpRxI4WsfvGRurmgTUdXDlWJeZBj
 fUbOSh7NYT1ZPfdhsmLQN4lNDxmmiKjIndaTLAHAuuvEJcyFmX+zno9RRgf2Fg41Nefr
 rNx/NMJjGjrQG4R+/7jrzOUgNWjndyd96ofRT765GROKCxovm1Pa23OpoqDNnMRYVSDP
 OXog==
X-Gm-Message-State: AOJu0YyJMSMMS+X3gSXUfTYfhAKljS2kpjGTPORlzTTqc70EYn3J0PWZ
 /dv/UnBJ1TY7LNyOfV/k+UKnbjA4nlUniTf4r0rZl0YJ6vTT51Xctz4UDUV5r2uO9L0=
X-Gm-Gg: AZuq6aLJj9Xfdbx4qFTrxP8uJ4WWTy6zl8+eATBu5R5K8VsVGnb9HEqyqgRSVcvsMIt
 6DzJQsXXlRt+t7XkOCf8kK712/T3lUJ+Xe6PMNPXRIfswvC3NFqwJKffSExUz8GAKbo1DcmwCGS
 Xes73DjEmI2IrjvSXZCXeP6271gam7IlXqrgruiB93noMdCMPKONtPh/gnfZu7DFn5jXTJ1JaNk
 3qFgvBeCptQy0xF+6jAxh4r5bsU+Xuwl5I3h6qBBpYLJ827odp2NpGeYp6/CsNLWOWEPrHGBAp3
 1LRKN5S5xZ+Gkazdaf8dv5lJZxvmPgyChSGLQWBGRAkhVYEA+stlg1HXrDmou4th3qAp7/1Qwye
 JjxMmossM4BXn0CIVI/ysq+8fqnLFxEUX1KAFfd0wR8TC/nT8FAh5WNV5Sht8PAmFyMhrw4I9Ht
 MWQN3Yk0YzDmOid7PfGJD4B2auWtE3BHFOqvinN7UzNylZ3R23fGjzP9jdecY/Vuk=
X-Received: by 2002:a05:600c:310f:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-482db493e6bmr45030585e9.5.1769796912254; 
 Fri, 30 Jan 2026 10:15:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdeafffsm200505285e9.7.2026.01.30.10.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 10:15:12 -0800 (PST)
Date: Fri, 30 Jan 2026 10:15:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Sergio Gonzalez Monroy
 <sergio.gonzalez.monroy@intel.com>, Harry van Haaren
 <harry.van.haaren@intel.com>
Subject: Re: [PATCH] eal/x86: fix TSC frequency query
Message-ID: <20260130101506.175ca913@phoenix.local>
In-Reply-To: <20260130171026.277418-1-thomas@monjalon.net>
References: <20260130171026.277418-1-thomas@monjalon.net>
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

On Fri, 30 Jan 2026 18:10:26 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> After getting TSC information from cpuid instruction,
> some values must be multiplied and divided.
> We must multiply first to get the most accurate value.
> 
> Example:
> 	before: 1000000000 * (23 / 10) = 2 GHz
> 	after:  1000000000 * 23 / 10 = 2.3 GHz
> 
> Bugzilla ID: 1869
> Fixes: ad3516bb4ae1 ("eal/x86: implement arch-specific TSC freq query")
> Cc: stable@dpdk.org
> 
> Reported-by: Luigi Rizzo <rizzo.unipi@gmail.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
