Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D280C98306
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 22:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BC6E42E5E;
	Fri, 16 Jan 2026 23:38:24 +0100 (CET)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41]) by mails.dpdk.org (Postfix) with ESMTP id 0D2F340264
 for <dev@dpdk.org>; Fri, 16 Jan 2026 23:38:22 +0100 (CET)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-9412f43cb9eso1543344241.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 14:38:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768603101; cv=none;
 d=google.com; s=arc-20240605;
 b=hpSeLEAlamkvIyhVyOY7Jwh+pB6AFSw8KjgyoECqKy1X36wHA5w1orvQXVdWYPwfRk
 tTkhCVu3EtWcLoVTXdzegcrIOM9fGm7X6jb134cfrFt3lNq6cio8uE2+xT71GUJhqTcj
 6IQlUlFh+BVoMgOM68BYqmILuYpTPWhntO9prc5fdVx0CuCpVt4QPrTsyfbXL2i8mF+Z
 uxkauLd1PpgJdke6QRmNX671RN3D6KdEOBCxnMiNV6Snlpm/qcIpF4Ntokl1XPxvzehC
 DyZ2a36h5eoq6aY97Ol0WZWhO+szFI607/DYfCjB8TMQ0Chc/3NNnkLYx85zU1mByJv6
 gd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=krtZPd4NS1JjfFeiRbur6QgF/SV3cgwtu7mnaIr2aJQ=;
 fh=7hGAxMJ0ahU9WdmcbH8esh2qqgZqbutD5AFuMCFFoQY=;
 b=VYGBCXEPsz0PRXZCRMD1gPTiskksCZAsGcZ/eyXmw7b+UPV7pSxaIJSP0l3ZEuhc4X
 ofpd58rST9C0ebQJ93Gilz8mzO0vFyTg9Z0JEHMoTBDgyj60KqcbAFmuxh7WmuVXZSzn
 uUYnhW/rD9fQpo5jOf6oDrkdKGp7PvCKfqiqfmHfKSADfoPZAZNP15irefEba6Fn7s9L
 MiZ0hBtEaLjYrNd0W4uJF/CB6WmKEs0ZFtJlJRkvU+WXAg+87cD9IK13sSfUERDDxLgf
 0vePBw/UoQc9n+zB2qLJaAdBRZjprJbYSgMCQIrRJvQEBqIoQdoRJZAUKNm1h2oNo9Lo
 W6hw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768603101; x=1769207901; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=krtZPd4NS1JjfFeiRbur6QgF/SV3cgwtu7mnaIr2aJQ=;
 b=RQAuEwoRRKsEYdhSfvlJOd4f4Hb6o8KrSY2spvzW+rDH8VksWgKmVPI64EYApoH6JM
 HRYKqLHucGxE2RTzwMilgjHtTeukP8YfH9vV3HINsASJLjAPFfa0TgPGhL8pdS8PdqmX
 6XJEephRL79f/Jb3Tfb50FkU7Vf3cfdcHUTMIf9xwJ3Mtj/9ws07odAB8ky0m2sIz6Kp
 qKnVpsBsy4gKu803zFFTzdsW+GOYZZiZR/sx8B5M8kKziB067b8wOBub/DUHICwQALCw
 T6MTk61BzjJ2ALBEibjzDSEzeMCs1VELPuhwP41O1IqkCP14zsEuww8dqX6cX9wMDL2P
 r30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768603101; x=1769207901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krtZPd4NS1JjfFeiRbur6QgF/SV3cgwtu7mnaIr2aJQ=;
 b=nSmtk6ukzOzngQRCDtglKOo/sK5UpdbU22fi7TuTP9vYP0qVRu3zyzZF0Vgcc0GmcE
 iEKU99rqYfmfm8Mp/I8wvW4wZ7V3AxneXFs3ePMBZDwtL5+2/E6xUZdD2s3UCFJy/KVN
 WvNHHzL/Fpsjv6qZsm20Hr433ziH/Ck4yjRpxXBjYHzSO8mqdaZlTHubNTcxvcvQfp8f
 r02WduRw2gpJUV5Xgk+OOscoEQ93KHwnPcYFYbZe3pEQVI8TdupnfZH4BuQBlikVK4PQ
 hMsqUmVdysrqYvBxWSxLHx9qPI2ZoPwqcs/gM52LRbMdRQ98j8JdW7j2R3+sxR7aasN8
 CVDA==
X-Gm-Message-State: AOJu0Yyth546liCDxFvHp8W0dItmADPZ1cS7jKmyrMllOiHxWWdc12R+
 3wx6xArfRjR3qnQSbOrJXdW/5QeLU+09yx6yOHtWFd6nLZlj4tHxJPF7hiPrpBoYUeA/L/fgUD+
 BN2bw2qcJr0p+rvfTH81RM8yNhzqoc6HImA==
X-Gm-Gg: AY/fxX70zK/mHTOjlUKZFEhG8nZrLMbpYrWvRvkb4v5F0p4V8P3z/sKP3LPek11hmZB
 MsdGMGaSNoC4zoYVHOwf1jfmIUJiOf72vLyxK8OdhpI1EJSJUIHX5WCRlKm11rsMpQ5WD/0c/Kn
 gzuIYhmxvzt4wsjck/NBHLjey2/7ymX2o53tF1Yj73vYdGnCpLNptqQkJln/kh1Ycy1lS76TCys
 6xeOZHudS2whCI7xy0ojqtDKk3TxBWfM3hy+vL/U3dBeGcZPOdXItR3OBxT/1o2whK5Nec=
X-Received: by 2002:a05:6102:6c8:b0:5ee:a08e:8c0a with SMTP id
 ada2fe7eead31-5f1a559378cmr1691717137.33.1768603101268; Fri, 16 Jan 2026
 14:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20260114160750.12945-1-scott.k.mitch1@gmail.com>
 <20260114215648.47820-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6566B@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6566B@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 16 Jan 2026 14:38:10 -0800
X-Gm-Features: AZwV_Qi6R6YH_i7kdK1ZNzHCUShHHADhJINU0HFyt7X4ar3sfs-Hoj1fUtwNgao
Message-ID: <CAFn2buA50PFVwSJ-Cus3C1_TZy=5Cwstwrg=+4tP4Rg_g+gajQ@mail.gmail.com>
Subject: Re: [PATCH v7] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, bruce.richardson@intel.com
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

Feedback makes sense! I will address and submit v8.
