Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCCD2629F
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 01:00:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C2F741132;
	Wed, 21 Jan 2026 02:00:09 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id D153E402BD
 for <dev@dpdk.org>; Wed, 21 Jan 2026 02:00:07 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so34948815e9.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 17:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768957207;
 x=1769562007; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mt4wHn/B/Uh47RVH/PXrZGWtnIKIt1iGhgyzhSV9wok=;
 b=OODhOsu1E7jzmvsaPTAJ2bxnLX4erwK2E4dMkaTUjkxD27yiQPxGBhs59YKGP1gFH1
 wo95AxPwtooKfErrc95FbIdBYPtLG86DcAoFb9a/Y0x+u9yCPZDAmTRHEMqLscIuvf/e
 vk10tnMKzhd9QXSuS7UMaEqfDiLVjfXbWZRXqdJ+MtDLFsQPMc0uXATcvLM8lXx6Yu0I
 PLzsPBTnLg5RCr+ixuf63wsvK5bh7/41su9pyj7CC5rxN1Z1ygudn74ggMXPTnKp8qi9
 whUfbY/FZ1yYUt+1zuVt2z5JI1Ext7dGm2uw1KogaoJGWlO3qq0Xt9yqKcF+dvwyAHth
 S0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768957207; x=1769562007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mt4wHn/B/Uh47RVH/PXrZGWtnIKIt1iGhgyzhSV9wok=;
 b=Y/BVaQFBbLkVmEF7ul4n64Dx481Jv/EjDW1SG4D7w1gFOwLuigmx74bJ2b+f1td3Pw
 JVb16TmmcPIaLucMNLAAs+4kHdoSpsNE67Jw1+kW5YoFJ+daXjdJVeF4mb8uXa4dMDTC
 2xz0h1GZE74+ryJaIOO6xYrnwgz5SwHSrP5+chvwGQkzvsC6pFDcz0fBu9yMQkw/wXkp
 SA/5SKTufTBNqgNz9zJlt8kFtco4YwHhF0Rpwuj2pEXDTOaRFF8FhwSK9dScZASUzqNx
 dRDNL7BGyp5acd2qfqxFeelg00tXDdcqOtH1+3u8ZYSG2Kgt2yReXbTn9cgyh1DrkoNV
 twqA==
X-Gm-Message-State: AOJu0Yx7tDINLWFMAA2r7GplqNPf67pPt6EWwMyoJOoKksvAUCROhIda
 iV7tWwZkh6nD+kHTrXXAmf7WMz73Z4+Qg//JmiGZsJg45UCS7+4Z9oTS9fyqxb42+0Tp+UvUulz
 HvvOl
X-Gm-Gg: AZuq6aJgMJI0URK9k6VeQEYK8KRkk5mv2fblepn+8C87RTQFpua9T9QMpCE30m++Qpb
 cKt5DPlJFE/bccVBOr3XXW4PTEKjPM4w1/qxv1mNn1vX6g5lYS20qLrK69c2jdl/MFgX/jQWlKN
 FlnqDNBy5gHQ1NY3zHyjmZweE9YCPqoybcSxAdYa9BsTxDe5hTxxnc3o3MX+Ahnbzla6Q9qs37v
 8c1X2leRywH2l1oSUx/X5Z+NyEXsqRVcEOosc9HoJXR5LgBo6yE1TJNxG4ah96EfNeJ+9zgvEau
 9GRLoZMDqvqvfS3Sn47VVB7W0fIRvtn3UjcJqWvuWfDWPGMFtA/Jo66TTjzWDRpE20vE9fYmZ1y
 JEtQhHLDPDQhR8why/AF1ykcM6kORZ7XXbg8Pbnhn7rizkDIurMpgII/iZgFa8KYhQ1MKAjYQCH
 5AiMjNcdgY7tcS2UY3tz1zlbGDbz6FRtj5gXVJ029f19XsoBZg30ao
X-Received: by 2002:a05:600c:45d1:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-4803e80438amr47356175e9.35.1768957206741; 
 Tue, 20 Jan 2026 17:00:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm331914785e9.9.2026.01.20.17.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 17:00:06 -0800 (PST)
Date: Tue, 20 Jan 2026 17:00:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/7] flow_parser: add shared parser library
Message-ID: <20260120170000.7823a453@phoenix.local>
In-Reply-To: <20260120232424.195059-1-sismis@dyna-nic.com>
References: <20260120232424.195059-1-sismis@dyna-nic.com>
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

On Wed, 21 Jan 2026 00:24:17 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> External applications like Suricata IDS [1] need to express hardware filtering
> rules in a consistent, human-readable format. Rather than inventing custom
> syntax, reusing testpmd's well-tested flow grammar provides immediate
> compatibility with existing documentation and user knowledge.
> 
> Note: This library provides only one way to create rte_flow structures.
> Applications can also construct rte_flow_attr, rte_flow_item[], and
> rte_flow_action[] directly in C code.
> 
> Design
> ------
> The library (librte_flow_parser) exposes the following APIs:
> - rte_flow_parser_parse_attr_str(): Parse attributes only
> - rte_flow_parser_parse_pattern_str(): Parse patterns only
> - rte_flow_parser_parse_actions_str(): Parse actions only
> 
> Testpmd is updated to use the library, ensuring a single
> maintained parser implementation.
> 
> Testing and Demo
> -------
> - Functional tests in dpdk-test
> - Example application: examples/flow_parsing
> 
> Changes
> -------
> 
> v4:
> - ethdev changes in separate commit
> - library's public API only exposes attribute, pattern and action parsing,
>   while the full command parsing is kept internal for testpmd usage only.
> - Addressed Stephen's comments from V3
> - dpdk-test now have tests focused on public and internal library functions
> 
> v3:
> - Add more functional tests
> - More concise MAINTAINERS updates
> - Updated license headers
> - A thing to note: When playing with flow commands, I figured, some may use
>   non-flow commands, such as raw decap/encap, policy meter and others.
>   Flow parser library itself now supports `set` command to set e.g. the decap/
>   encap parameters, as the flow syntax only supports defining the index of the
>   encap/decap configs. The library, however, does not support e.g. `create`
>   command to create policy meters, as that is just an ID and it can be created
>   separately using rte_meter APIs.
> 
> [1] https://github.com/OISF/suricata/pull/13950
> 

There seem to be  lot of build failures in CI for this version.
