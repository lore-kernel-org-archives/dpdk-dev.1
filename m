Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C89C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 20:56:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71D6E402DA;
	Thu, 20 Feb 2025 21:56:09 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 203D14026D
 for <dev@dpdk.org>; Thu, 20 Feb 2025 21:56:08 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-220d398bea9so20718185ad.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740084967;
 x=1740689767; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSv72qYKJI/LDcTYEW5t6NJIqix8kwJzkVmG9wWiohc=;
 b=UclfKWQeq6htxd2aIegbPq9SCS3GhZVTqdqWhxnYIJ7Yd57z6tNGhpr7zfg8UoBkY+
 IWOiGpkw6an9hQ8KXNzK6oA0anwhHJP7sMCmYuSgphW7kMt1ONqINDUeTRz7p6Dr4H39
 Sc9YFBuDKwvXyo87M8ahhToeoh1A2YVh4qQvYIttIOE8YhEiW/vefN++LqbumOVVWp37
 MHPV81w6m4nJ5JOXv/BGbqMyL+x2ybfeGrQvoKMj4z4BzDB5xL18A8yvi9RZ1Kxk235z
 BTl5GcIXeG2wfkIuHwfH6GIg4urB5QRHny4ilXIV8DIHIx+PsCex2dviOQC8GOh7If/P
 E4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740084967; x=1740689767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSv72qYKJI/LDcTYEW5t6NJIqix8kwJzkVmG9wWiohc=;
 b=CQA8OTNYUlwAxhVqdk3lHqSytu5oIbRgaq7NNrj0MsqCb+kXy2nKeGoA6+I3VB3WxP
 PcfbMfdyAf0FaZH6CF1srUavPFbLGNS/kv5mQh5Rjhmk2XmSpDVLhWC3Uok80+jauhIa
 UBMNAl91ekjXAk24WNnq3KdV+Q0DCB0mTL65CakLzS64aQrhZAOPSGLnrYqjN/jSdUaD
 G3Fdo3PAfSbo2BEPAAPfop+rJCup9PCoxC2t1DEyNLSQO3MMBOPyeTHIkMkg2BmWqO81
 RCRIttqwYKsWsa83kbll9VXyJe483U0+gWdB3bq0FnwatTH/LNnWqJgGhmGFuVVbYiXl
 oLVw==
X-Gm-Message-State: AOJu0YwRLOwDHiR1LbSckJep0EHt3IRVYQPLvaW+2UbWL937Kup5C9BF
 gNpjzxy6Uo33y7h5X21GyxT9JoqVA0KXXCESpC/OQc4p2upSxS/wRH5faPSL9pM=
X-Gm-Gg: ASbGnctshRiLqFasxgdFCBKWvlBiQjAvMT/HmMvcEkBCaE5A/rLmw/nhfbW59PoAoYp
 SkU6cQWNtN6rjAoWxN2HEG2mvQZnnU24mEm4ALiDb83anL2s15yzI45grVIa817bOnKQUHzCPkC
 inVRFt3kszV8QtZIg7CCppCfPHwn8/0n7mMCz/9OBWHbzc/nYUQjjVFs4b4xzAGq+LPUkeKnoYX
 NDuvq/HoVsDx44OVv/cuLTe0O3Cjcqp1aFGaUdYYO6kry1opJWpNHIRoabAnhxBOZYwWZYgSM8j
 7EaMOImni+PNEZWXR1+gBRST4XgygnjAAn3gyUJHikbosRGMiUtMqCEHzqTNX72jZ4oI
X-Google-Smtp-Source: AGHT+IFPIx/QgQoEwKEeskTZeK3zmUPjcT6OttzLLnzTR8OHG/FvIeYnzpEfjxoPn+imtXtovytKog==
X-Received: by 2002:a05:6a20:8407:b0:1ee:e785:a082 with SMTP id
 adf61e73a8af0-1eef52c926bmr443145637.1.1740084967170; 
 Thu, 20 Feb 2025 12:56:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326bcd94fdsm10225996b3a.53.2025.02.20.12.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 12:56:06 -0800 (PST)
Date: Thu, 20 Feb 2025 12:56:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: <dev@dpdk.org>, <songx.jiale@intel.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix fail to set queue number when attach
 device
Message-ID: <20250220125605.60807aa6@hermes.local>
In-Reply-To: <20250218113156.7174-1-lihuisong@huawei.com>
References: <20250218113156.7174-1-lihuisong@huawei.com>
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

On Tue, 18 Feb 2025 19:31:56 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> Testpmd doesn't modify the Rx/Tx queue number of all ports after attach a
> new device. The root cause is that "port config all rxq <value>" would
> check if all ports are stopped and the status of this port is still in
> 'RTE_PORT_HANDLING'. This status is changed to 'RTE_PORT_STOPPED' in
> setup_attached_port() when start port.
> 
> In addition, this new port needs to be initialized in advance because these
> information are depanded on many commands. Otherwise other commands like
> "port config xxx" may also encounter similar issue. But the initialization
> can't be in new event callback as discussed in following commit. So this
> patch moves setup_attached_port() to the time point 100ms after received
> the new event.
> 
> Bugzilla ID: 1663
> Fixes: 994635edb2c0 ("app/testpmd: add port attach/detach for multiple process")
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---

Applied to next-net with some rewording of commit message to improve grammar.
Should this patch be cc to stable since it has a Fixes tag?
