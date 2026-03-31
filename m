Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0FA10F9307
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:41:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C1B440275;
	Wed,  1 Apr 2026 00:41:17 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5F4A04026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:41:16 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so43048275ad.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774996875;
 x=1775601675; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbMn5Yb/IxFMVUYIObtALW/voN4SL9cnROPpn4wrTI4=;
 b=UKBxocV9RTUJzbfaVRh6Iom3IgRO/Fu0zEhTAO09DKN34k+qeb6Hvv243k4LVYlAFy
 jTu3lIOjpRtquzZGbjKlBMZ7XrABisySnoc/7eV1srXWYI9LYzLJ3faQiAT0FphX0UaO
 UPu3EJ0FMQIyFpMyCiKoClqgF96kzge9y0t2QITx4YpyHSWF0rryLkdpnUqjcxerEvKB
 QAHP89rSOrtgIakOmUNdeZN2CMzHisEp4IxYGbxYfcX0xv/TCzOvMnlmYaaE2QTFmoYd
 lNiQD0guEdfOUTtl9zPIkkDY8KTBKZ/8URSMvuKMsLVWwtITGsg28x29zCcKJxkgHdIN
 7+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774996875; x=1775601675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VbMn5Yb/IxFMVUYIObtALW/voN4SL9cnROPpn4wrTI4=;
 b=ikhAXCEuv8hklKHfIsVIFyAisAOHBAYZwrdNGWt6uyJ1n+3Tl9O3EPPweRuySe1kup
 bk1r32V493iM6JgB8MghGZt9a7PpLaeYybOaVrxlUnohWpkE7LCwcGRKhfxcJNwdKWWE
 EV0493xizEHwv1H7MkMUpvh24aLGGxxkkJExSgrnhNBu1rdGODgP6SWapl6wa+5jZxjW
 Qb2SjovygmXnA7ve/GEoF96tBPLy3t9Ho+MKXKVxLImoA04Kcsye/pgsHs5j/uDWxdC8
 1U/EIB4pHgp3L8FqOIiGy3zbUkfwZZCvJWwJu17UVRIh8JtuOPjUCxg1ug3txTkjFP+G
 QZGg==
X-Gm-Message-State: AOJu0YwAdqBKn7C93HYnMqnhYPytRvz4TLgTwkhveKEupMawqmm2KI6i
 /Xd7td4DgHp8alPvwvfXhE/uKE26qGDtu9m8vTU4bglpto1j7Lk+E3VobQydR4Fhqlsaf7A+KS3
 AV3E+
X-Gm-Gg: ATEYQzyvnAfaDmrcsYWg3M0WE4jeMuS7UZ2QKoryMfsRD3LM3g9KCQXyhGqrGxoZvqN
 F6iqVrfnZPdyAo3FSAIxBzEGNPt8pDfr3x0WdUcxieHVisJLRnUpR4QLzViD7+RBvjKJhjctKfU
 pCNqtEW01kktViwQoIQMIkCPDk9RbXqnwJ9xY9u68Sq/fW5BXY8rLN/3AkpGIjlT4/K4GTCXoK/
 2T0hJegiYTlfQ6nxSF08KBAfp7VSXrVmqfGLP/VIf35D2cyWVFeESsAJ2RBZZVr6Uqk6/qavvAk
 Rxe8+q1XWBNWX1SwQhjRTsVRHpNgZhkqDO6htnyINGP8iqnhWEqwwmmA1FfzNrIwDY9OJN8NK8q
 XqMYvF6rBuK9nFUiK3ZJYJ8Sg+eCcvvCCx9be/PxTUJc/3YfLBY5zt4CWDI1MJoJirvVl5fev2d
 rHWjwkId8AsRC9Avd8BS9r5l01wW0WuQc0hEE=
X-Received: by 2002:a17:903:249:b0:2b2:4dd2:dcf5 with SMTP id
 d9443c01a7336-2b269add3b2mr7754005ad.20.1774996875446; 
 Tue, 31 Mar 2026 15:41:15 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242765d55sm123268055ad.41.2026.03.31.15.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:41:15 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:41:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Nandini Persad <nandinipersad361@gmail.com>
Subject: Re: [PATCH v2 01/12] doc: correct grammar and typos in design guide
Message-ID: <20260331154109.279f0e32@phoenix.local>
In-Reply-To: <20260116201738.74578-2-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
 <20260116201738.74578-2-stephen@networkplumber.org>
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

On Fri, 16 Jan 2026 12:14:19 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Changes:
> - Use "execution environment" consistently (not "executive environment")
> - Fix FreeBSD capitalization
> - Use plural "these execution environments" to match multiple options
> - Add hyphen to "non-exhaustive"
> - Add missing comma before *telemetry*
> - Remove double space
> - Minor rewording for clarity
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Integrated into https://patchwork.dpdk.org/project/dpdk/patch/20260118191323.241013-8-stephen@networkplumber.org/
