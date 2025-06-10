Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFEC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 08:16:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C959402D4;
	Tue, 10 Jun 2025 10:16:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9B68240299
 for <dev@dpdk.org>; Tue, 10 Jun 2025 10:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749543361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dbghTnM7zC8BulbXNizOnLTsv+0xOQSs1F+XjdHAY4=;
 b=LP7qnSB284bftYwbq3McAQcut9xdFZJSpzQ8TYf0EhOsICWbHHof2e9lvjovM5Ay5QjyfQ
 ci9F8IIZk0bzZpSYJLNTBif1mw3EZ4es6t2ohVfISr2GPlUFc6tmjs0GvVK0rcFcPA0Ld7
 6dKXAYs90s9GZwHdJK8Iiap5u2QTmm0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-K2kpztb7PkOnSfRf1IB9Tg-1; Tue, 10 Jun 2025 04:15:59 -0400
X-MC-Unique: K2kpztb7PkOnSfRf1IB9Tg-1
X-Mimecast-MFC-AGG-ID: K2kpztb7PkOnSfRf1IB9Tg_1749543359
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so43338525e9.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 01:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749543358; x=1750148158;
 h=in-reply-to:references:user-agent:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8dbghTnM7zC8BulbXNizOnLTsv+0xOQSs1F+XjdHAY4=;
 b=Eh9cFcsyz4DoblIJStJ+7g/73DS8FkMmr4CiU8P49vhsXNa5oAMNCrc6j9cri+GLt7
 ZGzaRyqA0bnHCXagyHINMV/vMUHr/mjGUQioKqK3LsFYl5OrOLtvTId+uCEoSeqZzzP5
 i8PjEdk3jmheDW+eI9rqfEKSRDWDKjFplXKTATj2VOQ+h98w6F+KFYS6KUj4jNfSiwuX
 F2u0plq1AyjUWMsZmaxVsxdDLfdLL5C+YEk/5DlD345oLe0VQRz6Ak/J8KPDN7l0BPor
 4ntNYo9FKpySAHDMaWAaPRPS510ZhG4mmogj6+G1QJrR25tI/m+y5O6kZhNuoHEhYaJ8
 N1SA==
X-Gm-Message-State: AOJu0YzrRmNQabojdXbHDJjzRslVL9FbZ0O9mDWva85x1nyp0mt2O5lm
 7/PY1uhYJ2AXp2/czg1UloynE3AZvwHlsmUNqOC8zZbFRUAYwMdFnmRsFUa05LK+DWdk2w20k+b
 3DbZfHnYD7V9GrmO9CpLKIalMS2p9/WRIhrA2Jio0ABtr3XM/OQY1rxJgK1zZ+xHI6nxKvAkihN
 UvJykziaCx0yaU/z7uJcqkoP5fMc6R
X-Gm-Gg: ASbGncsmABo3I1OqOug/VvWOLFSTcO6DaL1vd1f+0XYZ0tNvnF+Iq41GtEaG2sOQmN4
 F2XxmAruSoqMNa1qOaHPZPGDyDnPuWfkvNXBcQpl/v3/v4XWcv7MrsxX3laxyyhGLSRp+C3urTZ
 zYvYT+Xo60d5mVZbFrmK4Nbg+E1NTxFjF/SL1lMQTe2X1WyrWlHFbqrSJJnER/TeUjq5S8QMqKq
 IcfjK5nBcVB3pXglqNf26qZag9ByxjOW72+sld6pQwgU+G9pXJ7DObQdawDEcFppEpnBMqyrHt6
 yw2n13NW4OgVY0gzK0+PrL2z/Ke+UbUhqdGN42QLNFUjj2nj3ey7QZ6uDrKMJ36J+SYv55L5xR1
 yTKOW
X-Received: by 2002:a05:600c:458a:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-452014ea1ebmr139515105e9.29.1749543358270; 
 Tue, 10 Jun 2025 01:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF771gjujyLV3EYzNb/ygiKd1fe6Gpw83DXnz/4G0B6AGcSxkeMbXPjFl5RSoNA1SXA16RWNQ==
X-Received: by 2002:a05:600c:458a:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-452014ea1ebmr139514785e9.29.1749543357861; 
 Tue, 10 Jun 2025 01:15:57 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730b9ad1sm129794345e9.21.2025.06.10.01.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 01:15:56 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 10 Jun 2025 10:15:56 +0200
Message-Id: <DAIPCY7NIG04.2Z0S17M8BPQUH@redhat.com>
To: <dev@dpdk.org>, "Anatoly Burakov" <anatoly.burakov@intel.com>
Subject: Re: Error with --no-huge when compiled with -fsanitize=address from
 gcc 15
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.20.1-98-gade1b762cdc7
References: <D9WNYZDZHISG.3091PEP8Y34QL@redhat.com>
In-Reply-To: <D9WNYZDZHISG.3091PEP8Y34QL@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xyhNNoPzy7FzdBTGiC7hkH4iPS206znhqAJq4eqaH28_1749543359
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

+Anatoly and Ferruh in direct address.

Robin Jarry, May 15, 2025 at 12:32:
> I recently updated to Fedora 42 that comes with GCC 15.
>
> When building with -fsanitize=3Daddress (libasan.so.8), it seems that
> the --no-huge mode (along with --no-shconf) fails at initialization for
> some obscure reason.
>
> "couldn't allocate memory due to IOVA exceeding limits of current DMA mas=
k."

Hi Anatoly, Ferruh, all,

Allow me to bump this. GCC 15 has been out for quite a while now and it
seems that libasan cannot be used anymore with the DPDK memory allocator
as it is.

I have tracked the commit that introduced this warning up to 2018:

https://git.dpdk.org/dpdk/commit/?id=3D165c89b84538f

I would be much grateful if you could help. I don't know the internals
of libasan, but I assume it shuffles mapped memory around and it
conflicts with the DPDK allocator inner workings.

I have found this libasan commit which "could" be related:

https://github.com/llvm/llvm-project/commit/7ede1c497302

In fact, part of it was reverted a while after on macos because of
suspected breakage:

https://github.com/llvm/llvm-project/commit/4e332bba2f3a

--=20
Robin

> Driver does not carry cash.

