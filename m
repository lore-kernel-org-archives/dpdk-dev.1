Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD62FF8867
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 23:01:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AB7C40285;
	Tue, 28 Apr 2026 01:01:21 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id C5F1440269
 for <dev@dpdk.org>; Tue, 28 Apr 2026 01:01:19 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12c1a170a50so13582547c88.0
 for <dev@dpdk.org>; Mon, 27 Apr 2026 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777330878;
 x=1777935678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtyVhJZyDo2KtGu7z83unRWhkjSGqQpJdx4PKTdhcio=;
 b=dBACsPT1NxOxyhRCkOb4g59KW9GUnxK60uIn79fWtOtSUsckyB+QPusI8dOVjlC4pM
 E8LB18DuVZndxxYcN74Jmo3dFtKadnXfvu0MTC7NMgLb8vr9TjErACmDQ024jt6FNgAp
 bYwtqJXqxwFWQye7lCCFb9YDDxLmmM52ceDX6/9IoaGr4wSICSwL22qFI0bffCv4axdH
 V0eeCTWv1ugFl8YQG0chRetEiXOYjFXR8fRC3wSSJJaLiPwBOZEFKJ5/SFZL9fBiFhfL
 lUqTFBUZ995k0/pjcU4x4VimwFtJWUd4Skt2WYrLaf9QHwZ7lN5yaXAZ4mEvO+bzQI80
 lqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777330878; x=1777935678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QtyVhJZyDo2KtGu7z83unRWhkjSGqQpJdx4PKTdhcio=;
 b=ahbL0iAScY0zKKNjWH+OS5jTB+A1XXUfycEPHs5MQlGK8EeDOtarMHeJ9grBiG/Ll0
 IX+abZbmHJnG4nSQqg6g8rARfwhhx1ejkdSw4JTWh7MPF4i8VBkXWUNSRGoAcisegUIf
 ydu/lbhbzaWyrZASojMl1w0OVsnQdR+ZSl7i8uh8l6well5TsVCbsQXuHkxh8YdPabve
 PEny097Qt19BSaTYAgBazUm8dBnxUbySy2AwhkzesY4hP0DKfxKzI7SJTHE/sDFDi7be
 RV7F00RbAY9MvVWeE96B8AOxL+3/9NTtBVffdT2ZosSXkPodQ7v0U2gFlGG9m+bbiWnR
 gYnQ==
X-Gm-Message-State: AOJu0Yx5PjoHvg61p/W0pWFaCb8nTwBXphhNy7kOH3W241AD/igJJk8S
 BLljblRn7/vl+Vuf2PxhhtbcyTlKz3bpy8VihC955rbB3K1Q6CfGezECoJJxB6ri2b0=
X-Gm-Gg: AeBDiesoObtG/+5/zSq6hSHfFh5h3b/dfXPvZYWDioQ08JoOBnQ4LuQu22AUlKufcT4
 4dB+ZGz/j8ofUv4WUyTdMrEkjV9pvZJ8fGEiw5ZBsKoI4nbS8wyq67z2GDYm4PmNtfFbf/2b80A
 yh/qVpWEXIOsvGAuYfWPCHWTicBYTFYwzO3HlSRlY4Z+2GfsLXj74oWApNThCXNX+IjqxtzTf2O
 XY/QMoCg1yF28C0xz5lVg3cz+PINwXrYT3a/6vO6/jJACimEwVmvAJstGVt7vYqDwDF4Ovi8fkg
 ddvOenHGK5Xn0uJQWVsBcoOLffMMzta1ZXkBmPL782qhFKAxDmgdjtQLiagQ7NLNJOUE8V66MQ0
 7Nz4w2YcfgwQmqUbCXJ4rfyR0UBsCMNMpihemxQNS1Tta5hp5Xufr/t6kKl1UJcKAs2HTy8SaTO
 NeLWqgJE0Y/b32WhXsx+2AGKUyhkiJvJcTVnFpnbL+Dl3wKA==
X-Received: by 2002:a05:7022:f94:b0:12c:8c54:9e6d with SMTP id
 a92af1059eb24-12ddd9aab32mr412637c88.22.1777330878494; 
 Mon, 27 Apr 2026 16:01:18 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ddd9b1e3bsm699018c88.13.2026.04.27.16.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 16:01:18 -0700 (PDT)
Date: Mon, 27 Apr 2026 16:01:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com
Subject: Re: [RFC v1 1/4] ptp: introduce PTP protocol library
Message-ID: <20260427160115.42ff3f60@phoenix.local>
In-Reply-To: <20260428010117.692626-2-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260428010117.692626-2-rajesh3.kumar@intel.com>
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

On Tue, 28 Apr 2026 06:31:03 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> +		const struct rte_udp_hdr *udp =
> +			(const struct rte_udp_hdr *)
> +			((const uint8_t *)eth + offset);

Use rte_pktmbuf_mtod_offset() avoid pointer math as error prone.
