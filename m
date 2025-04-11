Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EAC36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 16:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15ECA40B95;
	Fri, 11 Apr 2025 18:27:08 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 870E54025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 18:27:06 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso2339464b3a.2
 for <dev@dpdk.org>; Fri, 11 Apr 2025 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744388825;
 x=1744993625; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18Nlnr+2TtQ2CfcnjCJmn9iYAejdpQ+S+7LZ3+fnCY8=;
 b=plJcVR6fQdOwaePt9AQY1XIzcAYzu0BVYZedDawc6Q4nE1tkQ/R1JUbyQ8M+8i1iwR
 L98xz4EO1hoAnvogPAIimZ+thLyKSTDoNbXnnpkaAsn8Zrka8Utx7Y0gu0+X+irjTJdF
 rvQVv7FsFTSkNZSQvnc/Dv6pURu3+hWjzIGb328Xc2QzePO+ZyjeVup3fKpXtYkE37mQ
 QZmszJfxXDg98W4QxB/JQkmMuvjdhFXp5jVJNztS2WdosejLKoVmGUzzyQMSYj4wJp7D
 2qqMmnO4O41hnc32+NYAAFWzyc4ghT68ra3cUvDpLU3WzZv8tmAtQuu3GvUUsKhwh11U
 SaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744388825; x=1744993625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18Nlnr+2TtQ2CfcnjCJmn9iYAejdpQ+S+7LZ3+fnCY8=;
 b=hDfO2ilIeK+tmfgi2fFutb8TmTV/aSaAsqW5ARzKJ3GK4fXwQMwcQ5/+QZUDBotDz4
 BdtAK5Jnig8NCl63Ydrc2rcNDRA0Fu3eocz75pQjUL4d/HIATS/rCZpAoqAgutXC8Iyu
 uP1Hpp89o2iL0Gzn0TbNFdGsH6bKHLUkJ6ECm26AdAknxIWomt02xXQg6lKTWJNsyhc8
 8x7q/soKcg6hhQg1rI3CUbjlI1as1WqL8dO/9EJdjIIGoQEXt0ygK2Wf+62C2ZH5dd99
 W59TWPnf3L8ke8kEnMScNUaaIWCbwiY+eePD5Ore+OQihTmMok4ws/qbWdIMx+JpUjYt
 pfVQ==
X-Gm-Message-State: AOJu0YxjroClDnwQ6lHEFK6tmcECqBuY2qotn2y/2o4X4dvfsKV7MzCx
 8qEqce2DOE7EXmgJsOkav2//YGL2AYaYVcxGRjmCa6SjrufPsrMdTXNb5/sVkwHNQxal8hSzmh/
 U
X-Gm-Gg: ASbGnctECUDkiklvUSoiTW2znPzUCFXlzG8HjdE1DDiv8TgCnroC5mzbGFyB0MpnIOi
 405IWwgF1zpPsQ5X0J/SugzgoVZ3DlL8FMqZrfQPtSlYKWDo6KJedK8vufq0+kwdb64uTv2Mgzp
 FvYS03CJx5sqbMWXjtia+G9uqjblFP2G+8sakUMFIlZ178cL30ddLjrLygMe4rJVlf75pwn5NYa
 l+TKpB+F5C3NfN3EREXU1TdoLnHCRUXwy0Hbh74ereeh8cpKtteBc/mksUa3+0LTZ0wEdlA/PE2
 GyMlpwmWw1e1eaM8KECWCUVvqeObfZWN7OT9II0PRjfjaRtSYJRW/uQeVCf7udm8tHeGiLCNJpW
 SHcg20xzwn2u3g/45
X-Google-Smtp-Source: AGHT+IHIF6MSsAzgDapYewqmO5ySIPKmaw2D2dq7cVc76E5QtbdP0axTPXRvJrm8hWi8fgv/SY4Qyg==
X-Received: by 2002:a05:6a00:3d46:b0:736:3449:f8ee with SMTP id
 d2e1a72fcca58-73bd1193f28mr4795383b3a.4.1744388825366; 
 Fri, 11 Apr 2025 09:27:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2335294sm1807608b3a.176.2025.04.11.09.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 09:27:05 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:27:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chaoyong He <chaoyong.he@corigine.com>
Cc: dev@dpdk.org, oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>
Subject: Re: [PATCH 1/3] app/testpmd: add/remove multiple VLAN filter IDs at
 once
Message-ID: <20250411092703.688a1b65@hermes.local>
In-Reply-To: <20250411081005.1133509-2-chaoyong.he@corigine.com>
References: <20250411081005.1133509-1-chaoyong.he@corigine.com>
 <20250411081005.1133509-2-chaoyong.he@corigine.com>
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

On Fri, 11 Apr 2025 16:10:03 +0800
Chaoyong He <chaoyong.he@corigine.com> wrote:

> From: Long Wu <long.wu@corigine.com>
> 
> The command of setting VLAN filter IDs can only set one VLAN filter
> ID at once. For example:
> testpmd> rx_vlan add 100 0  
> 
> This is very inefficient in some case because it forces the
> user type this command as many times as the VLAN filter IDs
> they want to set.
> 
> This patch supports the user set any number valid VLAN filter
> IDs just through one command and it is also backwards compatible.
> For example:
> testpmd> rx_vlan add 100,102-103,200 0  
> The VLAN filter IDs 100, 102, 103, 200 will be added to port 0.
> 
> Signed-off-by: Long Wu <long.wu@corigine.com>
> Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>

Not sure if this is really worth the effort.
Testpmd is intended to exercise drivers, not as a production forwarding application
though users have tendency to be lazy and use it for that.

If consensus is to implement this, then DPDK should really have a way to parse
a range of values (already needed for cores). Then the library code could be used
here, rather than special parsing code only for VLAN's in testpmd.
