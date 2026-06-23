Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2296CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:51:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 982B44029D;
	Tue, 23 Jun 2026 17:51:49 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 3784B40150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 17:51:48 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304f590dd91so6785944eec.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782229907;
 x=1782834707; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sh/6NCRjwlrpILxRHlhnj6fCOtTN9vQ21OU64Hdul78=;
 b=VSzQ99k4ueCqsYvbcuMaflbp2nfmoUPHL8iJJD0cmbnPBuGjcMC3iUnhqRSjgx49Cb
 pfn4f7pZ+tjvYY8M8I23OX/1QwYI3jvqBZErtwgZvZPbQl8aDk7+nSK9W4z0a8zmu+hi
 hWhsvky0vfZXND68NuZbstMmBSsK+nGq3ypgyKkGYUCMeOjd1Xx5hfxLb+eugMITC9Ac
 piG7tV5ERbxVkooj5S7r+fSP2VHhcJnbu3cimzAZe7PKgx2z6xjtaGgor9/ucHujMwRs
 iI4I0mIE9wNEK/asFErUcL3jjw+DncU95NfGYO/Y1Nj5WxjgZ3Z606VTuBGWoECu0Zz1
 aZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782229907; x=1782834707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sh/6NCRjwlrpILxRHlhnj6fCOtTN9vQ21OU64Hdul78=;
 b=byhOuvgvKnYt/AjBf+uH6L+JnXL/xiMZpVKllSMnXk9lFC23VavTdGi6kv/mYt2n8K
 AmWjwp22TdJaotmcv0zw10fPBiRq5YfnpzcDIpsZQK2YTxYgClQCs6kw+ZeE05xZaDpq
 lvyFTGOqSxujXcznJIGVTz5Gbz6TvfRyk8gToF6NW58drWzfcw2Lig0ZVMQehrHTZK95
 YnL9bWG4C4/vyIiszEEgyqFahpj5IKZ5sfkzKnKy4toM9Tvy9C/m9f5dUU9vTPPtN12n
 tTGcRJElpN4mGtGpCxKUgnsE5mhOKOm7TUJsBfa2DHnp1ZPzV1hr4Tr2ud3q1X+SQ98N
 w4FA==
X-Gm-Message-State: AOJu0Yz+i+ft79QBR48acXszybTOrVT049ZGsR9uJ09SVgNAHTb6ZiVo
 FqZzYZDsUBrtf0WnGcZm0XMBc0y+671n8AJ42C5d8pqXOEo9wtM5C5PdefaSoh77hU8=
X-Gm-Gg: AfdE7cn4HM7pz7dF32uNIxqud/NpIW3P9oY0t1CmTCPhL3uzlJYSphZmBkef8qszLrw
 mYVIduBggvTC8Fz2aPLya3IWqtBdcCf0cr7/XXqWXL0azvqpVMIkS5lBhuspIEX0KCdDtymsT/4
 UEJ0yLHxRzAoDO13DjY1FrWvM0g+9Oj7VfUAuVuFXvr57wrSeo1VEHW2D4TwK6hNI4IacSYqcC+
 /CD6Pdo6kXHai8mgifclkl9vD/z5Yyyqto53M4APOGaAoEPLyPdkUkT472mf96PSwsc8l/zpAbG
 LZiszQFfaPuVRuTNlgbqnqWhSIQ39GKwSP4XJEsWR8OZMsH6uanzUBcRoiSZ/YYZgiM1eqY4zyF
 VLhiEJl8AHI4ETDdhhMI4kBq8hPwq6BMim3XlcyJx/ZWhbugLhy9oZ8US2Ol3nY3BOnEgJYDETq
 PxfRXNjE6uxSBRGFPxFFfO0l+RqxhLwOl0tiU+RzhVGnsumNZwHr5GKg==
X-Received: by 2002:a05:7300:cd97:b0:304:29dd:70b6 with SMTP id
 5a478bee46e88-30c06e346damr13640400eec.13.1782229906941; 
 Tue, 23 Jun 2026 08:51:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba57dc4sm16721038eec.9.2026.06.23.08.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 08:51:46 -0700 (PDT)
Date: Tue, 23 Jun 2026 08:51:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 6/6] test/bpf: check that bpf_convert can be JIT'd
Message-ID: <20260623085144.0f0d8ede@phoenix.local>
In-Reply-To: <c510bf24a3cd492693fc54f0b558656f@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
 <20260621162524.82690-7-stephen@networkplumber.org>
 <c510bf24a3cd492693fc54f0b558656f@huawei.com>
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

On Tue, 23 Jun 2026 13:57:35 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Thank you for working on this, please see some comments inline.

I think it is still worth keeping the tests split into two.
One test just make sure that some basic filters work as expected (match vs not match).

The other one is just doing its job by causing pcap_compile() to generate more complex
and different code. Since the packet we are feeding it is just a dummy packet, I suspect
all of the filters will be false. Let me recheck, if so then can look at return value.
