Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE8E103A999
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3E89402AA;
	Wed, 25 Mar 2026 03:24:11 +0100 (CET)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id E94394027A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:24:08 +0100 (CET)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2c0c955a481so7135891eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774405448;
 x=1775010248; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKeoUjnWlM1+jEGQGHGDBcOZ7JpFD/4prD2ViMIBSQQ=;
 b=ODAnl9j3WM8Xm6Ii2IRw3YYO/BimWYz8kO1Iah9YDPVrB0fd4blKUWDZ80OSkODjPE
 vdJ9eevfPd3PF1YOxckwQh35v1XR6p8XL9X6qFXThQLEfH8jvxeMXH8l6hrhQ1TUi/ak
 SC6CnCuPC97YKgln0nobfomCTllaEG53R9kGi6BaM3L65wVzGEyxDB+2dIEDjm9EoXBt
 e/IpJGehDkBP76QfvQHI0NVcVKDsbCUwLvtGPlMlvWDFW0uoAyE7XL29Jwta7az/zpXY
 b/r0f45WvL60W+62NKmTRMI//dYeT0U0kObMdLp44jyOV++RHECQ2yu+NX7xCwmjg8fx
 flEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405448; x=1775010248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UKeoUjnWlM1+jEGQGHGDBcOZ7JpFD/4prD2ViMIBSQQ=;
 b=Ece3cSROfSUHX4qk7+/e9JuxjkAMZzV9KDmbAWVWxXD1umvGp1vutI/PwD0Ok9D8mv
 B1nXlrv3XVw4LREMakiujm2NkJtCJH0JdpHTWEw2vvOD2tuILPNkrwVZTYEblPBL53lr
 faOkUJ9x49hViI2b2bOW7IYVDHAS/B52nArAxdGexJyusp6JgCshKuQpFJWb8J9mkTuw
 5oXlEL6X1z4h34bkXdkasY0H1OkMMf7Ok21ipAnDJpR5xOKGmJwKw5tId7ao3cYM5VrN
 41UtIcNkQRoZssrWoO7nfHYSqiRIJbEE4DsOvllg1ZmCtBlWmhBDhMAQJTRaQ/lgxzPa
 HbOQ==
X-Gm-Message-State: AOJu0YwwFwm9fkBrzmGl8IyBvX1ZeTgB1zWU59mGu+bQApIDq7aQ4ORm
 W4DgErhu+APGLeuz/fQSnxtwlv2fNSQsZxh2uBFBu0HAfK/I4pXmW+85e2gRR+WeMYc=
X-Gm-Gg: ATEYQzywa+0pFO6lg4JYmVv/AEwyNEUshPKgDjTbNu4n/i7fsxpaHkhCylZfwbFAWLM
 FQILiEh8zW4buO12oS7y9nlGex9PLReFKcgUAhjweQDrOQ3c4m7j810vUecD1zoJv4CpfxDA5lq
 ZVzBfcytcfNv0q1DX+ZgrKXI13zRIio9KJuIiXTELErKTeEfvoGT6LGySXipA2t8g6EmVnlTNEb
 zJECc4kMdrW+oDyDuAnBnWjaevRpCmToWTv5jBHDlIh0eowpu/5QpGGiyYdL4ZyQ5nFvIoEBjL2
 0uiwExQ++KjU2Si0lY/vQUPUId8JKM2n0AMWseqlgZbteNZzP6FQhgIpxB4RCv6UE/mZp9398FU
 x4+jn20eSghAERNuzc8aNO8HiZfPUSBq8uAgKjyv+v6pBZbAEze41CzbEF2nTzcPUhVK+/Q0041
 sn+eEZvkkp5j0ttFRG7Dh/cMiRgENBfb/uOvA=
X-Received: by 2002:a05:7301:1e8c:b0:2c1:5b3e:3ec9 with SMTP id
 5a478bee46e88-2c15d3a6809mr783173eec.23.1774405447841; 
 Tue, 24 Mar 2026 19:24:07 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b31bef1sm21545160eec.26.2026.03.24.19.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:24:07 -0700 (PDT)
Date: Tue, 24 Mar 2026 19:24:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com, aman.deep.singh@intel.com
Subject: Re: [PATCH v5 08/10] ethdev: add getter for per-queue Tx rate limit
Message-ID: <20260324192404.64eac4b5@phoenix.local>
In-Reply-To: <20260324165047.391137-9-vjardin@free.fr>
References: <20260322134629.94633-1-vjardin@free.fr>
 <20260324165047.391137-1-vjardin@free.fr>
 <20260324165047.391137-9-vjardin@free.fr>
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

On Tue, 24 Mar 2026 17:50:45 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> The existing rte_eth_set_queue_rate_limit() API allows setting a
> per-queue Tx rate but provides no way to read it back. Applications
> such as grout are forced to maintain a shadow copy of the rate to
> be able to report it.
> 
> Add rte_eth_get_queue_rate_limit() as the symmetric getter, following
> the established DPDK pattern (e.g. rte_eth_dev_set_mtu/get_mtu,
> rte_eth_dev_set_vlan_offload/get_vlan_offload).
> 
> This adds:
> - eth_get_queue_rate_limit_t driver callback in ethdev_driver.h
> - rte_eth_get_queue_rate_limit() public experimental API (26.07)
> - Trace point matching the existing setter pattern
> - Generic testpmd command: show port <id> queue <id> rate
> 
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
