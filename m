Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B3CCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 20:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D988C402E0;
	Mon, 20 Oct 2025 22:16:36 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id B90ED40151
 for <dev@dpdk.org>; Mon, 20 Oct 2025 22:16:34 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-33ba38ed94eso5239392a91.1
 for <dev@dpdk.org>; Mon, 20 Oct 2025 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760991393;
 x=1761596193; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rJnHB+GJOZodjadYNpQHQ4j3W3slz2yC5MVZ+uxhVcI=;
 b=QrTOvn+DULyOciXEALoA0itODQNDw5HvwB7O4s960ml9HZrANXImJswjewnJEUWJc4
 5AWhRv/orL9eHcD40a2eV8gD2i1wiubdNG/26anG6+KZcTWMR8LuS5UmDsR1NTwL+Caf
 zWBJPKPFCDY3ohkZVMDHIMXAEgoBwh7RskpSErzyZI/0of6GirL+EV2+5lWlRZETddBO
 Pqj2rQ00XurZSxvC+NbxD7rnBZbBBHvmlO6aE+BOe5KZ1YAb4G2SMwiFlNOfrzvM5dAg
 vXhVkiQIUTcI9FDQCvmWXECqO1/7x5qp16aF/A8dgdbyZy4OSUW5pgo689CcYKTa4Vc8
 MeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760991393; x=1761596193;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rJnHB+GJOZodjadYNpQHQ4j3W3slz2yC5MVZ+uxhVcI=;
 b=X8fgx6u8Tgk4g2x11OdT8VMQCruCRGdlrhphszOZJKGMhrsftEVhnBWc/BOfkng43F
 Td9JClKUFNtYhHkQ0eujRFSprHR0ej+NNkBw+j2cVFbZMxohOWik1ky+4iapNdQsguLd
 cftpkNGIGLmcZsCvsVqZJ4Xvkb2nXcFhxLBKGq2plypU6Zya2LLRCWKaISR1SRUBJL9L
 juQQ4vIrK5AsCT22aISK8LrcGGYjP5Gxf5hp/4xIDSU2eNnzp8OxdZiywB7CKrG0qsUi
 GBGvmRnVLcf79kXyehIAnVUhXDoAGSD30GFETqaIIAxmoECENIx3gT+BLLr+LKjhXnl8
 52ZQ==
X-Gm-Message-State: AOJu0Ywn+YxmAg7HeXUStcy0KJSOpauQze+JIqS3iP/exOeSPtNFPs3N
 ly+thEezZJw9cLMDVPYF1M6PhwM9lyRYw5S1rl90QT5FV7SEcjsRxzapjswztSUpMUfWg67IfVA
 cUguY5oiVaw==
X-Gm-Gg: ASbGnctdY/U336//XlsX2ZxC7BE9nGS10kqxTCj+TiMCECqV6U5Fy/R1Zpnexruq682
 HExVrjH3gx1glna2msCNdZf6QdiS+OA2t1evJ2HtJn0n8x85pfWGhHavN6EcTs2aqwCVDHMvE+k
 Xd4Y71QYweU3UvxYSZpVE/snxD0dwDgm4u8BM9yVkxeg/t3WlCik5u386WBF0oDBiuON+JL3Dye
 8YcT8miZfMyF/P6mTS83Krb6n3KkDvVn/TwZGSpftHte7Z2EWskiBFiMWyia5WZ9rm9L+KoB57k
 HWJARPkc+LEjPFDYQZSmdLIosi3c8xwnh6en0HEffM1uIY0cw/sKNeiTME9TtFVcHBGUYts8Zml
 vaNPFjqrinCoB4oaYgWLz3RUyC5cZDuO1p2bXu1kZQywhY9JAHsKVRlccaSVJ+v1xSk08QjXrwc
 CJEdLUBGZmHG8HQ9QddRAOXBLQXVqIm0SEjXpRTIf0A/Xx/r7A+W2uduryyj8C
X-Google-Smtp-Source: AGHT+IE+anCB+pwRGhs3gEQjOiddeOchEI4YxDcQncNlqZM+G57kiP+JN/E441Cg6nuN3r0GyHGevg==
X-Received: by 2002:a17:90b:48c6:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-33bcf8ec5f7mr18885622a91.22.1760991393453; 
 Mon, 20 Oct 2025 13:16:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5dfc89d2sm8953953a91.23.2025.10.20.13.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 13:16:33 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:16:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org
Subject: BPF elf examples
Message-ID: <20251020131631.2a6a0de3@phoenix.lan>
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

While looking in more detail at BPF use of VLA, went down a rabbit hole
because there are no tests and no examples of loading a BPF program using
the elf_load API's in BPF.

Tried using AI to generate tests, and as usual it sort of worked but the
example code generated won't load or work. Is there anywhere to find working
DPDK examples of using BPF load?
