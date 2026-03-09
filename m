Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B3FCA17F
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 20:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C532A402BE;
	Mon,  9 Mar 2026 21:16:18 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id 1C270402BE
 for <dev@dpdk.org>; Mon,  9 Mar 2026 21:16:17 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7d73dd9cb9bso1212924a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773087377;
 x=1773692177; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+8IdmL+wAS9bPC1Dk7zMDMdwJuEJWYSP+P5EWlQqRE=;
 b=G+3wgQe8vftorECyJgvWGHpfw4Jba8CYMFgwIERheAEI3yNGeWlTiacL8QBakTH4Ht
 x/fvaTLJyTG7W4shBKL3jNBdwZ0/EimIVrxOkcYv13Ez5yYAkH1PgrcJFe6Zl2/KuakR
 sfLlTdTAfU5y3nfDns4onx3oO7lvgHnsTIWNA73zKpI82ZwneTkZeHQQoZqYjI8bB25f
 tlCteLaSLuZm8GMmU7thghASrzadX1L43yL1pCs+rxiygc9bRSvQtZfeWRTXghOvK53h
 YA4WH3wR5Ev8nvKnkEnu9IgYVHJ3aadK8gg9OeWapZUL+os1MjGmD7LXOCWDC/6jvSfD
 TKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773087377; x=1773692177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z+8IdmL+wAS9bPC1Dk7zMDMdwJuEJWYSP+P5EWlQqRE=;
 b=fudGbzhPlxtKliYXIKjGWlNUM8QCwP64DB/z4BRRCbFFeY3lLhKWX9nqnl6Gq45pRl
 UiX3REDNE8syLUz8CO+Fc8PXJfZaNlFnAeeiiIBWEU+YFj0XCICHJDpXJbkYWZWB+dRN
 eNwUTA0iNamB+zyPNE8KA9oG6RhGhM1laFZKj5vf9R/RfJl0SOwQtZzWKg5ZPOeNKgCA
 JdtH+f9gLkaikaaXyoVKQ2/ubO70M3VDv1nBO7nL6aBZ/5S3kVu1HKLgDwQdB0T/bXfp
 U8eFz/Vs5peuDtmeVACvXd6vAl8plnMlSdyACqLkQxEbKqcBz/I9ZzGJMUEaRrj0jys0
 1yMQ==
X-Gm-Message-State: AOJu0Yxfhs8ku6CPdjLvxllCLDTgLMbeVD6fJ6VtKHQwfAq0Nami00pW
 fJFSoC263x5nBHvjw9eActN2zEwx9jeFZXewjeVQb3rbp7o5Lb/MLiA91f2MjRvgMUw=
X-Gm-Gg: ATEYQzzQZH1GAdydGty05rHqs93m8Mx509YtDs7/Mgm62BU0sF/y65WDY1W9pT//ccp
 df/xkzzYLvOdAWKqshYgoT+FrFxWuG66xLMcVM1wZmBWi6bKA+nmKaaVA4hNGwa1Ocjab3IUcvT
 QbiGkvbmqiWSeBv3zyGk1unbemf/5ZDZtjNwdVy/r9hxUNyHxeOsHSnNngVsl1abWW1BseJT1HU
 KiMe4v6g12ONUDUw1QHSwuOYoAmmePKbAvG4aEdgD38uJQQzcgCyp++mOJY005M73B2ZOinkmLj
 uPv5yhsN0ZkE+lIRbCeCiBteKmX8eSaxlQrJKdT52KGHoXW0rKmeVcfn6QQbH3NMxBDXckWZTMK
 R8O2zqKh6yLDTHFVF5bWQvKTVjReADxmTHJz2Bm1avOTv8pGvDYicHwlc5v3wzxPf+mED7tdAs1
 P3xy1zDxeHcWmuyx9K5vLVzZc6FUWYXip3rGymkWxbuq2v7A==
X-Received: by 2002:a05:6830:442a:b0:7d7:55c2:d768 with SMTP id
 46e09a7af769-7d755c2db84mr1497515a34.18.1773087377158; 
 Mon, 09 Mar 2026 13:16:17 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d75039b811sm1737323a34.16.2026.03.09.13.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:16:17 -0700 (PDT)
Date: Mon, 9 Mar 2026 13:16:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 0/3] net/af_packet: fix MTU handling and add jumbo
 frame support
Message-ID: <20260309131614.18300719@phoenix.local>
In-Reply-To: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
References: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
 <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
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

On Mon, 9 Mar 2026 17:10:18 +0100
Xavier Guillaume <xavier.guillaume@ovhcloud.com> wrote:

> This series fixes two bugs in the af_packet PMD related to frame
> size calculations and buffer safety, then enables jumbo frame
> support by deriving the advertised capabilities from the actual
> TPACKET ring configuration.
> 
> Patch 1 fixes the data size calculation in eth_dev_mtu_set() which
> is too restrictive due to TPACKET2_HDRLEN including sizeof(struct
> sockaddr_ll) even though the sockaddr_ll does not consume frame
> data space. The formula is now consistent with the RX and TX paths.
> 
> Patch 2 adds a bounds check in the RX path to prevent a heap buffer
> overflow when the kernel delivers a packet larger than the mbuf data
> room (e.g. if the kernel interface MTU is raised externally).
> 
> Patch 3 replaces the static max_rx_pktlen (RTE_ETHER_MAX_LEN) and
> adds max_mtu, both derived from the configured TPACKET frame size.
> This enables jumbo frame support when the user specifies a larger
> framesz devarg at vdev creation time.
> 
> v2:
>   - patch 2/3: fix Fixes tag to use 12-char SHA (checkpatch warning)

FYI - I have another series that addresses different things in af_packet.
It adds standalone tests and it would be good if the test there also check jumbo.

