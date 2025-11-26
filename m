Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD8ED111A7
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 21:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EBC740B9A;
	Wed, 26 Nov 2025 22:43:39 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id EE1804013F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 22:43:37 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4ed82ee9e57so4079571cf.0
 for <dev@dpdk.org>; Wed, 26 Nov 2025 13:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764193417;
 x=1764798217; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R07g9ltLw2bx5fpQSwSAZhdohZ9hmlqCPn6syEqQ1RU=;
 b=GJ2RnG99c/ScKfS5aqRfOdh1C4Rq9196TKbUIWciId4UJj15s/tgRlvzck9kO+Ll28
 +rivu8O79cfEX4mEoZKbZPGYWAgF6XOCGnEbkKyWcFxOzgWymknd12RXE7ZObG77OG3S
 YKhFlUqeVIcNKxML/Hpa9rV1FYB6ISe/VK+edKTwJOe4SmptNk375TXNboLVdHfU5H5l
 OYEuHxlGFSP3UdJkoj8woXaN6+FS4OS9HrL0KkEYZYKbNKP5cZazlfz17FieFLt0+0pl
 rwMubSkqK9mzpUyoZ3tOWllQFbD/UFgukL0o+LCYdC61UOntwmcOMfRcDS5BCvC2Cez8
 rr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764193417; x=1764798217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R07g9ltLw2bx5fpQSwSAZhdohZ9hmlqCPn6syEqQ1RU=;
 b=D9hbC9Fa8jNnAZuMCY5IVGRfppDotiAcU6RUZe8KNHYZKa63dz7RcqZ6YmUxOp9MAK
 0+uUDncQVs0yW1UxSTWjZYbD8sQ23lN0QAgbzmglnrL7UwncbWnSlAhuY2OaNpA0doEK
 oRIqXO1T+Duxs9nR1tSRjb+4Z7x/VYHob7tpU696p1mYQxeiw+mj8RD6bTOrMZ0qz0LR
 ybTg2tijxaW0cLNp5Ioam8chOtHpIFwPYcwJaCEevJFhtjY8CC2WdNf8IfriiUPbc7x/
 ui68OcdSNEiyndEvLHU8RtTZ3vx2SUZccxxwDZwWd56dsN4WPj8JbYHrdg3MMrafCHxA
 KUUg==
X-Gm-Message-State: AOJu0YzboTppBeOZ4HhwCELy7qAGF2WTEif+L8sbD0Gr3BYY/aZqJOZK
 6f7tG21HCqqJDwpuDV4ImIlYOAnjOnZWhrtb7dRYjm5I097w6caY00/LqL9E7Y8st9A=
X-Gm-Gg: ASbGncsBcYx5bx//AruZHD+CcUhZLn5RT+wR/ys2l6vg9LX+NVfPM40GH1Z6KYvMVRC
 9Ga8FeBmscbTO9deMMpk4ntZDrKEYQ5WIiD1arEQZGZ/JVROu5M9GQvlVDiERPnM2HI0pc4bETN
 mlHYzgNlTH20CjPXsu1rv+EgsWP4iNrOobM4WZQf6XY1V4J5+eoNOrDCqBSWtpUmolbvYAv5eP9
 AMk5KLPnC3xZ87h2YFS8EgMMTTnbdlG7T62m9CKWtcBcmQHUeucDUh7cl1pVMFk2D/7zG1SwMAQ
 LMSotEb+3tveDfNQGGOZXqOGTnGkBE/iwsMorWgtBFDxC3z/bIbmDfH7qTGufhyovttRGa7YErI
 GtX6OY0zoVzLUwaLAMBdP+KJzE05VmfuczzkvDzyzAbdmaf2cboJz28BDAfAgBYyIeSAzaLb32X
 N0iFRf3j90R440fYU2eeChsRLSZwr7AOft8RnnDUPWA3Wx8PxmyWRS
X-Google-Smtp-Source: AGHT+IFEZ0qHwT660RJGQjCkYxuKo3Z4f/zTq4T9f97DRrx0PESV58mFkKMt7QWaDV1WjNjVwTPCEA==
X-Received: by 2002:a05:622a:424e:b0:4ef:c4de:2ac9 with SMTP id
 d75a77b69052e-4efc4de2ba4mr65686441cf.17.1764193417310; 
 Wed, 26 Nov 2025 13:43:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e468484sm153668376d6.14.2025.11.26.13.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 13:43:37 -0800 (PST)
Date: Wed, 26 Nov 2025 13:43:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH v2] net/txgbe: fix the missing old mailbox interface calls
Message-ID: <20251126134332.77ae1685@phoenix.local>
In-Reply-To: <9E296F0580980C92+20251126085649.8665-1-jiawenwu@trustnetic.com>
References: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
 <9E296F0580980C92+20251126085649.8665-1-jiawenwu@trustnetic.com>
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

On Wed, 26 Nov 2025 16:56:49 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> For different devices, the mailbox flow between software and firmware is
> different. There are several mailbox command in the txgbe driver, but only
> txgbe_hic_sr_read() was changed to use the new flow.
> 
> It lead to other mailbox commands timeout for Amber-Lite devices, which
> is required to use the new flow. So this patch fills in the missing part.
> 
> For the sake of code tidy, txgbe_hic_sr_read() should change to use the
> locked function txgbe_host_interface_command(), and this function could
> be change to pointer in struct txgbe_mbx_info for different devices.
> 
> Fixes: 6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---

Queued to next-net
