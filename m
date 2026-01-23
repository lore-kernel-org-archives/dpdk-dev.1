Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423CAD6CFC6
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 05:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D7884021F;
	Fri, 23 Jan 2026 06:15:37 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 1A7DB400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 06:15:37 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43591b55727so1616723f8f.3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 21:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769145337;
 x=1769750137; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YrVdqGiRGh+mI9rHLDv5jEdys+rwWKepXprgQr4dOs=;
 b=cBrT7OjfokZkRsPd7XohZPSElSbOlX/qvNz2d6J8zT37OvQNkT4Ml8H371qk7BnFdk
 4+BaFP2fS7HUq84eRAPv5ffAWOwuZIU27YWxyBRX89KO2qfcl8b8ujsWAWkqpVjpVIQP
 p+BeIy6zEqIqWiVAgpFS3w65sjFNMFe+k6NuFaHO2kwMcc0HodcocqnGR4iAO/314KfO
 xuRaE2IZaBT2HTjINJqhUODFb1mztreI0AdvkVM9nH5EmB3WY0vJ0R8GTf4Ff4e1flly
 coXeFUvCYgUpmbyFxy7k7jz4RtAyyDKlmMl3+8nZKVVqKnBTA0Iz7XaBRqfBgwbj4VKW
 oXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769145337; x=1769750137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9YrVdqGiRGh+mI9rHLDv5jEdys+rwWKepXprgQr4dOs=;
 b=K5WTv4ef9In6Oj6jUP4E3z3oRYBAo8r4MR3GwDZtxfsALHROoLGwvJInNj/OXYQErD
 oMzBuobWGkJw5jM/FhfG3MHabEXXTIQySeqvkdMN2hvpw5nafCIKboKyxUzLOOYO5FXU
 WokUfhXnZHR3BhMOmc/OwdMOcp3v3D/5QvV6VleUiQkAmMicvXfDuZQ3MGkhkmawkFNE
 NFSPLp5G+gf6dbuAYNtZTNv7UyI4vtAgQVg21SKv0kZEJJxFaKOfsXDryDitDG8VUKdR
 bKNECny0EEfQwLsFCIXBpEWxPopee2+GUEs2cSsRu36fDOT0wF3BXKCvRLA7cjqemr58
 l+Cg==
X-Gm-Message-State: AOJu0YziN+OV5llXMMSClLfkynsSR1ZoyPtRmt7X1EEFYzOo/Zp6VrzV
 LHPTQEzEtxo9p6pc327FsjfZPqWoa8MvcIzczQLZ5LgWrJWeA/ZueuhvkFmul88Upv4=
X-Gm-Gg: AZuq6aIU74vavHiJdko0KsQucLnfhGAyu1MGSQK6Ty0528YM7XnW4Un2m3mG19BSgTK
 8sSN5M266YtDznq9I8bK1G/U+lubrsLcNcrrfM/Sl//DqVaxLZQU09o2eqQW90RN+NH90utvEry
 w9Vw+hRNCa8qT55xK6EVMzFT68touX8ewewwJjVmQ3PLmRKAzrOqGW0hOfDXbI2EyMjnXHFhTN1
 ApSu+8/2fyWooXcKrqHBXBkdR3MzV2kcI05mO866uFle/AB/4XHipcYOD8pLJ4oHXpJ3iZREXIf
 465aGZp12tqc+wGBLM9iYM1Y7fgZRaJ09G/GPL1Fl4IlB5m2xFUJ3SZmLXC/kaV27m8GUkJAuBZ
 BhWGO6R1VUMhzL2I6/N4mb/UIFZj0dhNISy7cSSa1ZG8ZOkbucB+s00SHwDi+752hSrBHtMZanl
 so1YsZSzhK3HSDojmhy+lJMGL73H6R5R/qHsh8yoEqXHg81LWs67RXSl91TRUlBN0=
X-Received: by 2002:a5d:5d8a:0:b0:435:add0:3d77 with SMTP id
 ffacd0b85a97d-435b162775emr2767238f8f.55.1769145336719; 
 Thu, 22 Jan 2026 21:15:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e715bfsm3911739f8f.22.2026.01.22.21.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 21:15:36 -0800 (PST)
Date: Thu, 22 Jan 2026 21:15:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <hofors@lysator.liu.se>, "David Marchand" <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH 2/3] bitset: remove experimental bitops workaround
Message-ID: <20260122211531.44eec1bf@phoenix.local>
In-Reply-To: <20250518080556.675092-2-mattias.ronnblom@ericsson.com>
References: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
 <20250518080556.675092-2-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 18 May 2025 10:05:55 +0200
Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com> wrote:

> With bitops APIs used by bitset stable, the workaround required to fix
> build for GCC without experimental API is no longer needed.
>=20
> Signed-off-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
