Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E91EA8124
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7B1B40609;
	Tue, 10 Feb 2026 15:44:12 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 20DB7400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:44:11 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so41089895e9.3
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770734651;
 x=1771339451; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4vRUBpBdbqoXOEKy/sM1XIRHwW8bK29zUmZQqgs7E94=;
 b=F4ZTuWCeM3NCAxFWfNCYF9B2RY2fzxxFHa3E1tueAtweL5RVKMHzpvErhxXP5ZFkVN
 HNOn/g22aM9v+9NhaD45uBFZGc1JXE5xBgpx9o2ehxzEDFbCIGkXr00NZvXFpuX3FpwK
 QZhdakdiRdLB5QFmJUY3DZ0zKYcmpTib9Yq1kKlr8Qqle9f1fwdjzhzjFJ7TOJ9Syz9e
 U3OOr9M9X30SU7FDGxINffZqEn3OJtSm8gBrk+JdDaP+aqvTJggT2pGPG+B/3YjCywEW
 hZmc9v0P5214U8X5kV0/cfipqeZQwAUMERR82JZnBjKsTtPejya85lwrx9VdoFBRhqAA
 FuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770734651; x=1771339451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4vRUBpBdbqoXOEKy/sM1XIRHwW8bK29zUmZQqgs7E94=;
 b=aVjKCUaroZZnLtbqipBVdb90kkfDG2l60tvO3J2UdKwVyAblCMA9xxLScVBMBuZQrz
 gN7VyNOrYoyD7//OHbyKj06h40U4LOeJA5E7UtVx4syFh1jX538IXnsoRp7ai1B9b9E8
 bsDJUBR1hdEB5BsL4Xbr6NBEy1y2ck6qY7+I8ZCK0PkrEp2G7W3GGsZtbvX6gugbec2I
 1Pxg9GqEABdtW+OME3USTYiajmK0atByj+OhMHjOsdb65Kyb7Nj6vmJ4INBloIMdofCG
 ag5j52Kr9CjKnYvJkltLp9UCZwPIcdv+8aN+C0cetjyQ5cHcxB3ILgQrAikGlSMu20Jg
 1gHQ==
X-Gm-Message-State: AOJu0YyGNH2r66H2picFETM/8tjmEncwpi3cMuJbR/0qjuvgBqBJIc2N
 KHMTwpCTB8lfr5+JTiG2DO4+MFpGPx2lPbgTREhODYJSbt6VMzOzyycAeXO1lv4pI9kD8fIMGgZ
 mgCXI
X-Gm-Gg: AZuq6aKwvsYmSehdlwq2L0Y9KEir0QxpEvUe8cXiRA+Nl9gKaMd6Wi4r+Bv3uGLLh06
 9eysdpLRSl2WVQA6omJRjjRAuDEhQrNsqLDRQOPpuTNjrzgcqQR9T1is0JRm1GvKOTCZoxMNfs5
 sYJW4zxmi6iuE35g97iAcWlhuCy8g7twOta3aOkw/o1Lr6b8YjXZ9QcbqY0adidpKYvNxZV675H
 i1OWcqrdbPdLZ8U6FtkYa65rpDlYMYWNpk8GzNGbkYHwd1cbwVDdaSAn88A0ufuaFdEEBqphXxv
 Bgyca5D+7PO39rUxbEV0Z3DyfQdBnBxpbIx2RV0CzjlpOq/Z44sT9m4HFOZiIrQd9Zmtk8to2jF
 5h2VgoQJkrTgj9OQVmQNiMo4JwP5FSDF6ftZzawBur6AnzZBumG1APk/GduEz07Y37/3RR8sCFf
 oNn2cRQqZ0rVreFnxpqtcbXnl8LbXYNZu/jkNJDsQIhB7F+QakTcIe59gR6h/vZa+mAMWuOV1uf
 pE=
X-Received: by 2002:a05:600c:528b:b0:482:f12f:f35e with SMTP id
 5b1f17b1804b1-483201e3759mr221668635e9.12.1770734650540; 
 Tue, 10 Feb 2026 06:44:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm72292555e9.6.2026.02.10.06.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 06:44:10 -0800 (PST)
Date: Tue, 10 Feb 2026 06:44:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
Message-ID: <20260210064405.36bb5b6c@phoenix.local>
In-Reply-To: <20260202113659.24052-4-sismis@dyna-nic.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <20260202113659.24052-4-sismis@dyna-nic.com>
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

On Mon,  2 Feb 2026 12:36:55 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> Introduce librte_flow_parser as an experimental library
> exposing the testpmd flow CLI parser as an optional reusable component.
> 
> The library provides:
> - rte_flow_parser_init(): Initialize parser with operation callbacks
> - rte_flow_parser_parse(): Parse flow command strings into output
> - rte_flow_parser_run(): Parse and execute via registered callbacks
> - Lightweight functions for parsing pattern/action/attribute strings
> 
> The parser uses a single global instance design for simplicity.
> All parsing state is internal to the library. Callbacks are invoked
> for flow create, destroy, validate, query and other flow operations.
> 
> This enables applications to reuse testpmd's well-tested flow syntax
> without duplicating the parser implementation.
> 
> Other applications should primarily leverage the functions for
> separately parsing rte_flow rule attributes/patterns/actions.
> 
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>

I fixed a couple of checkpatch warnings during merge to next-net.
The break, use strlcpy, and spelling.
