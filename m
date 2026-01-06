Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C6ECEFCE6
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8712D4028B;
	Tue,  6 Jan 2026 19:07:10 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id CBC89400D7
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:07:09 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b843d418e37so15927566b.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767722829;
 x=1768327629; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NySz5u9UGwNZvLrV33P4IZ/vzgE2Xp5XNR2rbj6DYUg=;
 b=LDo7bxYp0ogIGOQpC4Mueo8bJQbX5HnY3aVhXPfL5L0puBc9TKgPlRVQUNQC6b5V8m
 8cuJwnHbcTsBxGBhwImTnIyXUwhxWwovT7U5lXgdGP8kipRqPvdpJtu8FZgoips9XDCb
 9DZ3ctAHMUXKTnRPWm/K25WBF4d+4uFAePUVbMgcIBRofmov9yjmQDGpue6eDfQNJ03B
 kqGQAg6rEYwye2usrUKL4cI9oKg1cbXXJrzADBj0BRDksVxVR06+l7DjtppevRSUdrcI
 /Zxi4Byr1af5BRO+AuGFyHSiNAOganuEix/xyDEqdfcRif3wMfpDx7/3nAiw+sn5xhOB
 LdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767722829; x=1768327629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NySz5u9UGwNZvLrV33P4IZ/vzgE2Xp5XNR2rbj6DYUg=;
 b=qm7BAQAi4aQTQwpWeamLIpautmnhfzYHWMaa/M8W21feIQdkLsToCowomSx78744GC
 4DUalaCLIb8CGWu5DzU6D3EEHBoPJIjNhIw8f3l7x53sqmzXjB/IHh5EMVkYafG0nBkB
 U2621abDJTcR0ZNivYrx8prhAXrr6dkqYAm5AdG39ZBcORSz4d/5IEIPX/3Cs9IxzFPw
 qQQox3dFd0kJ40e7lkjPmR3rUyMmsplPeOESKADO4pXuXphOIbKf76j6wB9rPjtibIk4
 /IWzYabYS2/bsE6eGiqAhO5q992xiZ5WwTRu7akTCYmfb7Kj/UZFCyKs5pqoJCmGGu2U
 o/Ug==
X-Gm-Message-State: AOJu0YzKXzzPKxHs7xwX6/46VpxCmb0wTzPhSG0pMFcq0gN3beBwYrrs
 38W/buXRwoIl8ND+PCi0RNqqJiEV59DKpJAtn3nd4ynolXngpu7Qj8MiISsuW36lr2M=
X-Gm-Gg: AY/fxX7PcB1v2U0F992caWgR0QWVVBHdofgKWkQzH/ZsMl/GnDVF7kH1qLL8fQ/TPb+
 ZANO4Sj+4m4E/uBzHVzvvKidb50+Jz9luIscJDV5QlNq505mT5Dx3lsnTI3suXZZRrbfGzGCH/N
 4fqrExdA5f32TDH8MlOouaZFeb3ejqGCcUQ7zcRXIiXaKWCsfBO9pCGZui1qewLeStdI0rs2HOQ
 yhf7BfUnI//05ERvRHepddyXbSZ/q2SQeyICaGBCcitpucAkserSmG2ZGClCNAJIAzUy4dgA6q4
 RFFikKcGhRjflDwAVhCI4OjXdn+SLqLEhBk9nzkCqqBVRFZ65NN689ZFg4y1y5Jdzvzn67uSVck
 98mD8/nn2N3f84Cs82Tkx6CBA0CuRG/iEPAnmckGR3tkoPWxG0/w+JTG5B9xxbqVrzKLyvjV4Xk
 1TmOuUK9WsguoE40qkqb6xfdtgWmhiF3pqKliSR7MEDvB/ZQQy2kKl
X-Google-Smtp-Source: AGHT+IHFVhLHhe6YinZffuuwL5nwp8CgX2Ks8Xo3w7NzLc2eHTm7YpvYxKAuiVo+5bcCJIEaCr5B9A==
X-Received: by 2002:a17:907:94c3:b0:b80:3fc4:3762 with SMTP id
 a640c23a62f3a-b8444c5a755mr6936866b.1.1767722829391; 
 Tue, 06 Jan 2026 10:07:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4d0290sm279933166b.32.2026.01.06.10.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:07:09 -0800 (PST)
Date: Tue, 6 Jan 2026 10:07:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 4/7] test: add flow parser unit tests
Message-ID: <20260106100705.4a27da00@phoenix.local>
In-Reply-To: <20260106153838.398033-5-sismis@dyna-nic.com>
References: <20260106153838.398033-1-sismis@dyna-nic.com>
 <20260106153838.398033-5-sismis@dyna-nic.com>
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

On Tue,  6 Jan 2026 16:38:34 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> Add comprehensive unit tests for the flow parser library.
> 
> Tests cover:
> - flow_parser_autotest: Tests rte_flow_parser_parse() with various
>   flow command strings including create, destroy, validate, query,
>   list, and isolate commands. Verifies parsed patterns, actions,
>   and attributes match expected values.
> 
> - flow_parser_helpers_autotest: Tests the standalone helper functions
>   parse_attr_str(), parse_pattern_str(), and parse_actions_str().
>   Verifies parsing of attributes, patterns with various item types,
>   and action sequences.
> 
> Run with: dpdk-test flow_parser_autotest
>           dpdk-test flow_parser_helpers_autotest
> 
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
> ---

Should add some negative tests to make sure flow_parser doesn't die on bogus inputs.
AI might help in creating more tests.
