Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860DBD216A8
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 22:55:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66F1A402E2;
	Thu,  4 Dec 2025 23:55:02 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id AC22E402BD
 for <dev@dpdk.org>; Thu,  4 Dec 2025 23:55:01 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so11495805e9.1
 for <dev@dpdk.org>; Thu, 04 Dec 2025 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764888901;
 x=1765493701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=7W/TuVOi9efSJpHD/3/7mpR4N6iKAfz/V+p/JkIaAlg=;
 b=K9ZM0mrMKBtxp4IidIUfVitolEEf9oPbETFM8cvUhWAqsJVAw1/6AhvCxoNcAtHPje
 iLjxbsWZbgp0PyjEHwwKqPBTxt0K6YaHHIkVT20EOohIy89/y/PiFoicj4zRjDLwEibK
 ej5emZFuY4rRmEeiA3BiCEfY0TEvBlr8Gu/M6jHvBitqYZUZnjHvDO6pCGsFOdXsbm9Y
 xk4J27MlgD9m35Hk/1NdM6OkQjXEEaevT/ZrvFSZVNt8V/eoeLPqWyOlmlPQuIIg3VTe
 KQg94VHlT4mbkafW0JUSiBAPx88SFdYu5N9/r8Fd0oddImVSMtfpZ/el1blG8B7XLkd+
 sznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764888901; x=1765493701;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7W/TuVOi9efSJpHD/3/7mpR4N6iKAfz/V+p/JkIaAlg=;
 b=EPOlZgYbDbLt6EN8V7tHKxg6Qi8rpZ/H3WP8QdJe4yo0/s75JxSrMFPgEeiBf929Uy
 zTtNdN0lNxhCUTnOXvVA/cJDj2SWXpCivUJV42vBMvL4GooZc/ZQOh10ThUolxfMPiE6
 HzZsJyypUI4x506oKLMbUzoX2Jtbw6dEyuqTxfQl6rv2PuzCeFmPYCzqjcMuJnhvXGfq
 SB9xOtCu2hUpxPG23yKkMU5b9DMHO7NyPTOpyBzc/csQYokLHtWwJYh5mDf3irnlqhBn
 lkLgOihVfeyhm7MLktuD4nfL5f4vPQxZQPigFil0UGIuqPLP5VhCFatVOCBiGtCJU/u2
 ZkQA==
X-Gm-Message-State: AOJu0YxnFkWh78minFomtYs4SwW00nI2nJGFuAem9OZc59cJoT3ayhBa
 nZEgq8VEDzAeK1LS1oT2CyTMmmmWvlJjQcoFy6FlhZGcR0n2iWqG0vqc1UN8wjzxHXlLFQF4Bir
 jA9QC
X-Gm-Gg: ASbGncu4+lE2QhM09/yav/Bnl8i+ypD5MwIE6IeY3YAl81lt3hJFCpA2QNGbM5sC3Fk
 bPsHLK3dc9idC4TFZNdQu9wjJ1sHQy3EUYhrS8QQj/VbXdvmx1u0a9E1agSZzNcWemhxPLEoVJZ
 waQ/D6/bVTL06waiOu0kuFaOicabgnYMgYBZgts8vS8Uef9mDPEyXFPTCszHqEowZFuZPNTWOxb
 O0aQrYwUtVJd/4qF8wg7TteO/uz5oHoZLSYmA6wWlMV4FVVLrOFqnnwTuXC2r1gpte5Fq3h3+KG
 0tBvRdfK+UNWjd1BtISxZAzyf8sia+iQ9zxfXMF/dQ/MKiX3sLQSWo3aspAp9q/uhm6wsdYbxkp
 /8w15RBd/dLjrh80orfQyB0ZK/joNG62kK0M+u5epTaSbJ/ex8z8EPMa+d9/Hz3CxCMLESMQvEh
 YKv3brge0qEHu78L9bSFzZg0a1yDmGC9w+9H8zYXZ8f5jS8N8Tn2aIbhFxvDSMhEs=
X-Google-Smtp-Source: AGHT+IGkGElRk13U8fKlesKhfYbWd6YhmT0YCgBeAYV5WS8YS8bi9RnAnlhJoBxfp8Smivz4c9Bf3g==
X-Received: by 2002:a05:600c:46c6:b0:477:7588:c8cc with SMTP id
 5b1f17b1804b1-4792eb19ee1mr53606515e9.7.1764888900161; 
 Thu, 04 Dec 2025 14:55:00 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b1522e6sm46358475e9.13.2025.12.04.14.54.59
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 14:54:59 -0800 (PST)
Date: Thu, 4 Dec 2025 14:54:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: "Is all in the name"
Message-ID: <20251204145455.5b6e8f8a@phoenix.local>
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

The exploration of re-enabling compiler warnings across DPDK has led me down into
why format overflow warnings are disable in lib including EAL.

It turns out that current code is rather sloppy about putting suffixes on names
and the limits are rather small.

The limit on name size for a memzone is 32 character, then ring code adds 3
characters so rings can only be 29 characters, then hash adds 7 character prefix
so hash table name limit is 22 characters...

There is also the issue that file name prefix is used to create unix domain socket
paths. Linux and FreeBSD inherit a limit of 108 characters for that. Which means
the allowable maximum limit of file name prefix is much smaller than the advertised
PATH_MAX (4096).

For the short term, the plan is to add the missing length checks for both each
libraries name, and for the file prefix. With release note because it is sure to
break some application that was getting by before.

For the long term, I there are a couple of options to expand the names.
  1. Rearrange memzone to use flexible array length and put name at
     end of struct. This would allow arbitrarily large memzones.
      - should also hide the actual definition of rte_memzone?
      - should also not mark memzone as packed; packed generates bad code
        some times and if you just arrange elements right there is no problem.
  2. Bump memzone name size up to something much larger like 128

It would also help if there was some convention about naming.
The logical option would be to use a dotted format like:
        zone name = ring.hash.qsbr.XXXXX
rather than current practice of arbitrary prefixes usage with _.
But this would not be enforced just DPDK wide convention.

Can't fix the file prefix/unix domain socket limit, but it should be documented
and enforced.
