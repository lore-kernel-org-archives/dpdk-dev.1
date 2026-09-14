Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E9FC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25E5040A7F;
	Mon, 14 Sep 2026 18:47:58 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3F99240A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 18:47:56 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so133345ad.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789404475;
 x=1790009275; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wBLig9XsgavOUjk0LIWBDIgoYeyswFLIX4YF8dJnV9E=;
 b=LhWOxP/ePWu7gBo26vzum72OUn53ulXZvLQnihft16tYuf9uUIzidIATTVLVjMptfp
 t2B6gRdWBZgm+0zVT7YsaMhFJGr8x70L1tJRjBoqk3j4FpqX4RIWIIGQ5W+rBIJ49/LF
 rnoGMPFCEGrJn7ktC8/IX+KN9enRu1noZ5gBDYyudca9q+5gnvFpl0leAx5QmDZQGwEW
 nyfAiAurddbhwlRw3BbCT8ibzVGBb3sqYhttKHtuFqWTuE3mJr3vYm0QWAFwuEvfDodD
 lCwZCNx701fDJ8Jf0cPy6F5qYnxGlN6PI2aqEuUzNE9cp2A7n3eWc08Dqz0jc+jNR2Hm
 ppnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789404475; x=1790009275;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wBLig9XsgavOUjk0LIWBDIgoYeyswFLIX4YF8dJnV9E=;
 b=JBPCE9Lq3e8SOi3Bde5vdjsK2r64rTeUaU8QeVVsok6mMDtc2TWexL5AxMHPryyEtK
 CqxvKVR7rCeWXQjguGgtvLdEH7fpURHgMoiL5TX0FprfMluQzSuahFO8cITh4OJW+DZ7
 VTam0+d22tczQ1jUyXiIR99LY+kSb3mooYlGQ/p1CqYI9+OKvQO+TlxrOBGmac/n3hx9
 m3lBmAkSelgIZv2VI4kaR9CTFcfu0VpuWo0kFWxbm8Vd9YEF0bSL1IYkqoQP8SmVURKp
 e9ywMFWPnrBacATIygl0M+XlQdm7EfbdZtqGxowF0KsOxSRnqWHxHA+npRekD5aJ4j3B
 srag==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6rLLeHAteP6Q9qz2MbLliDq6fPFvr4dgLZKf09ECag3T4KLIRPPMLiYEO1Fm19myyStU=@dpdk.org
X-Gm-Message-State: AFuF++lrYj4tVPA3R+hUqHwYrKjXid64XLJV65VxmSNQhQ2PujUwgHFp
 lKsYtDGUFo32YRCs6A76qT8eCtUYFCehyyE3s6uTN4vhIVm0Cx56z5GAuDtUxJ0qcdTtK09oJ8H
 kMpWa5QU=
X-Gm-Gg: AYBFou2fei1awidbOQsIIZ3PAskv9G+td9Ivf5oVYn2ILFlPBfl+Nih047dTWItXBXw
 aqptF9CPTDjXfzlDJWcPq6cXIl8DW4JnG5qHNCE7+hDvZJwqYM/pCB/Hj7/Ip+5Xqp0wJDGtAFf
 UebQAhVoLY2fE1VT+BE7+7muYowWE2WASKO1ZNcKOpz3EdxVLhhT5NdgJi2RLlLsRDVvGQ1IfRW
 yrESJ8cfyBTNaZSXaCJ5SnIKrGm4jEzFDjZdcapa8VOYzxu7fqfNxKLwc6OHKrZ0/wCB3KjB5l6
 6ioPCYbhx6Ij0/TI6utCEVG5tBjPY2U+4el74+uursjBTVapZ4l+u/NZQBf7KNANCeTrH7ApR7k
 M/pPEdIaGoDsZ4ysN71BeQJTZ8LlMbp1QDCArQZRHNnoU4CqAMuNcO62J+cY59NA/dfHNdzTuQz
 1SaqUFqE0toiA4PGYwQ09FjL7YISrj5lxH437ZjEfddhFnNIK3IylBddu9lsIT/TqZO9OVCQEho
 xQlU6TOHsuyNuUyp9pk6TnDHXWHMd5LErFLWf4Z
X-Received: by 2002:a17:903:2446:b0:2d8:d4d2:d13a with SMTP id
 d9443c01a7336-2dd7655b5f3mr2465365ad.22.1789404475318; 
 Mon, 14 Sep 2026 09:47:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2ceb6861sm51801775ad.36.2026.09.14.09.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:47:55 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:47:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>, "dev@dpdk.org"
 <dev@dpdk.org>, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH v2] eal: allow setting random number generator seed
Message-ID: <20260914094747.6a96a587@phoenix.local>
In-Reply-To: <8bf95eb0e0704401a1168a4e4fd238de@huawei.com>
References: <20260911225845.3168061-1-stephen@networkplumber.org>
 <20260912161744.201627-1-stephen@networkplumber.org>
 <bd0242b5-44d8-40c7-8928-4586f0191fe1@lysator.liu.se>
 <8bf95eb0e0704401a1168a4e4fd238de@huawei.com>
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

On Mon, 14 Sep 2026 12:04:16 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > 
> > Provided the test results depend on something that use the PRNG before
> > the test driver has had the opportunity to call rte_srand(), controlling
> > the *initial* seed may be required.
> > 
> > I don't think this feature should be controlled by an environment
> > variable. There is no precedent for that. If this functionality is
> > deemed useful, it should be an EAL command line option, it seems to me.  
> 
> +1


I thought about that but getting command line options into EAL when
using meson test runner is awkward (not impossible though).
