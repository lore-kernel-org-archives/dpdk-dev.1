Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC5FCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:18:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5364240E43;
	Wed, 13 Aug 2025 16:18:30 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id B42EC40265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:18:28 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-459e20ec1d9so64479405e9.3
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755094708;
 x=1755699508; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBSNptmiXbJCQ8oo8I2wTncTENh+F+WLOsuxkT7ZpV8=;
 b=JrcqgHJgTXPNGydSlQCgU+/Gq0zLOelLXruj/XR08A2JcF84wGp6VGwypUER42FRg9
 r1PRR8Kfs7CECj0ao5eJNYijQQ/4OkXhD1V924YoPFGiq0P8FZCYMY3EIMmPmp2v4L1l
 OzNOoY/caNcACrGI2ve9Sk57iPcGz0+SE7O9Iv7Feqdo4RykvzNlQM3bPpKPsAM85Wpo
 1nmpceaD8KU8On8WDa6gtbPMVSLZ+crxRn2mqyPAsqb4OKrlklfe807ykKKviwEUdpVe
 EREJyTDQAvmvgXyOnjziO8oyw+j/mG/FHz84/ur1QjrL4aJpf4RajuhHoeNde30TSJTp
 +q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094708; x=1755699508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBSNptmiXbJCQ8oo8I2wTncTENh+F+WLOsuxkT7ZpV8=;
 b=AxPsD1NNww4xWWeJCUWuUN9voVnUTb1b0vE2V4T6QDPcy0ZYnfCYR2Zpisi+E87rnv
 UywPUWO4Rm5z22LvMrX8Ll4sJK/sMM3Bj0ewyf4EmgQSxiaR/9Emc1AMeUweaqYFM3HI
 HXQSBoRQMC2dU1QuBwdI8uo5GvV8WyhpH642LgwK927kITaWl1p0qxxymTJ5sg2vqskV
 lBHkGCTAlUgVsa0dZLWP5SdD6fL6f5WOeWIBftirEvhoK8PZ/Eikebs59Ho/81qPB/ms
 9+Vf4IOYaIf5E7HA889vB51+5DVojpOUKuvoBbuym6hhOyGVs54LHVV69K1s6LCv9l6a
 rcHg==
X-Gm-Message-State: AOJu0YwbRxYVJ6tuv5pPdWq33cKkomAu30WfuPW41MHeE1fCQiUOFWZQ
 c3mFavbj3PTAlce+l/QH1G4Wkja6Kbz6Vt9mizY4q9d3srj4zc/Hwy5jNHc2EgqddqI=
X-Gm-Gg: ASbGncsAJB68P0hoHaEB4QKv5njJdDVwhgxqNKstDodzVhAorBgYOJDehfts6BL2pdx
 nZNWLKgeCg9aasmQFYb9TVzit+PMF8/bUorY/udRsWgdWZ3G1I3VHOiLOlGO7Wqbnbls4rywYrV
 xoiZqi2DUxcQJmOiTIaUylVoJogtKG7HybTbFI3UpjCkKZIyIEWbHfQYhGvggHMrpPsLIy7U8iX
 z9bxmtn2ufQyLz6eJhfAjywopYmia6j8OYhGBOClmqfa9RTZ2IvwvXhYQvUxN5WCakpUOfvZW+k
 iHJsz0fbXa6HFhy3EhEB1l6gcoiuhG3S6RM378kphvnalF6uy06lIosMe9O1RIXKUEA5SD1vZF5
 h4kmqMysTYJxPXaRBiUrlok9ZoIO5uPQi0CwXNkxMBE/2z06UPVcxDQPc5x6l4KbRlK/0zsEnFk
 8=
X-Google-Smtp-Source: AGHT+IFGnQ5DQo5XwCP1aOSqIa0IfkXajmowj6iPktq5LZfjz3lleyx6/MEZ9m5gDNGJ1J2uBr8eCg==
X-Received: by 2002:a05:600c:35d2:b0:456:1d4e:c127 with SMTP id
 5b1f17b1804b1-45a165c8e69mr27809165e9.8.1755094707975; 
 Wed, 13 Aug 2025 07:18:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a5212b2sm4414435e9.16.2025.08.13.07.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:18:27 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:18:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: Re: [PATCH 1/1] ethdev: add link speed 800G
Message-ID: <20250813071823.54b6a6ab@hermes.local>
In-Reply-To: <3325626.aV6nBDHxoP@thomas>
References: <20250812144249.316120-1-thomas@monjalon.net>
 <20250812083431.6502e587@hermes.local> <3325626.aV6nBDHxoP@thomas>
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

On Wed, 13 Aug 2025 12:01:53 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> > Looks like will run out of bits in 2040...  
> 
> I observe the max speed doubling every 3 years.
> So I imagine we will run out of bits in 2070,
> or earlier if we have new intermediate speeds.
> But in any case we have at least 20 years before it happens,
> so it looks safe to me.

That was just my lame attempt a joke.
