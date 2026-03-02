Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568E3EB362F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 19:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A6F340A76;
	Mon,  2 Mar 2026 20:36:31 +0100 (CET)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 385694028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 20:36:30 +0100 (CET)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1275750cf9cso3846867c88.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772480189;
 x=1773084989; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HigNlsuIlyTfEtCAcIuUUp3+lRWVSfPToLU6fLQY7iw=;
 b=WAVsO2w2EYeHss14datSZMXCv5sAkP39pNeHN2RjwFdxXZoIzOO/V3Zcez2H8B9BQ0
 eP+nMx2jHaAhiyC5UMvf1JT4fg36HTomv88YSMf4bLjT0ikznxyjTiK+BuXZQTbgmL+J
 mah9QX8asCM2bViRWkRNJXWjVS993KyYuZkkMnDeFB2vvpYsXq+t9CkhVxjyy4IjmOSH
 K4t2IczxiAfq0S1LbbPkdo+gX8xt+7ein67O0H0Oa5urQpYjMKcAVHXmqfrA4NgGg1q7
 mCGL0WHEKU+TpxV7GCfUQiTnP2kEYN5fFUfXtfho7+vBeEOLPrlbN4m2py/S/7ZxE1/p
 9wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772480189; x=1773084989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HigNlsuIlyTfEtCAcIuUUp3+lRWVSfPToLU6fLQY7iw=;
 b=JarX8c06mkhFJgrsxUAHT8XDrn8h5pM4HEHvpYrVQwN3+JydNSV1tots+rAioZRm1/
 A1Skc+4M1xHJQ1QDv2N1Mrj4xs+s0Uk7caiqyHN5bMcywSzCqmrXtHo6E3XH3ZWq93Cy
 1JFBdIkyaN606vQqkLoFBlLVV7m6qlbkMhFcs0DSZaNu5D1MFBOzgyyIBpz50NGDqKvA
 Dzz9OzcMSkUswhs/awq6uiglkQFO8klLSrETZCdwThXdHK9DYqUX+J8j9pJwbQQqIPT0
 f1+yiP4WQbAbZ3uzeJNppYEqCR1gb9o/FdVkKOEejy02obbVG6Kuq5akPYXKHG5H2p5Y
 upiw==
X-Gm-Message-State: AOJu0YwGi91CJq4jgTXeGJToG2O7KHMSCH5aSCLTsm8CQ/uKivFgTlk7
 r+SqZX67sIorSwOoM2I7vW60fngSfWVmrPA76CK4aY7zIa0rrapP18Yup2wquyxj0mA=
X-Gm-Gg: ATEYQzxRslCpDSjeXtuSUpIsRtZwfXQhhg4gJU5EUsA7DHEDyXOXRo40cs38hzhPRpd
 NTO6URkCTdd92BAF4Z6+t1nUmcrLv5/mzQgkAstFsf97co7g9p0rTxBbxkTaBpwjTRq/JBruE0d
 XReFXML2HlJjVquS45o0eDvMRb+jVL/g6zEP+dq0xE/LEGnpelN/TuNVnsEdRMjrmEUiqjzSfTJ
 NuJahw4HRBj3RR+Biqsu/8GKgNlptCONjR9G3rHBh35c67ydoWH8EDmVqGquE4LDhyWr/Ml+4gt
 GWH9moLMZqY/8MYLwBk0X10iol9tYSdg6dv+0v/7DmXIxohZe9orcz3Xp8K6NnCVPJC95hleaNg
 YwUJsv7jGjp/OUtj67qzsfoPhEVPQV4VvHUw4tfqGVUOtXBUVl4ReQbUr8tMfBGZrcZbLQ1kBJ/
 HeBsDFNMP0lL4SwTzcpKw23OUkUPW7w26z8x2XsiwRNORpFYYnxlwImBwvdcqR5oBk
X-Received: by 2002:a05:7022:68d:b0:123:3103:b22a with SMTP id
 a92af1059eb24-1278fb68a91mr5376273c88.3.1772480189233; 
 Mon, 02 Mar 2026 11:36:29 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a32633sm17284144c88.9.2026.03.02.11.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 11:36:29 -0800 (PST)
Date: Mon, 2 Mar 2026 11:36:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tejasree Kondoj <ktejasree@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: Re: [EXTERNAL] [PATCH v6 1/6] common/cnxk: replace variable length
 state array
Message-ID: <20260302113626.7197873e@phoenix.local>
In-Reply-To: <PH7PR18MB5177D9FC140A12E555D8B5FDA87EA@PH7PR18MB5177.namprd18.prod.outlook.com>
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
 <20260205175750.653353-2-stephen@networkplumber.org>
 <PH7PR18MB5177D9FC140A12E555D8B5FDA87EA@PH7PR18MB5177.namprd18.prod.outlook.com>
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

On Mon, 2 Mar 2026 19:06:19 +0000
Tejasree Kondoj <ktejasree@marvell.com> wrote:

> > diff --git a/drivers/common/cnxk/roc_aes.c b/drivers/common/cnxk/roc_aes.c
> > index d84feb546a..babf149ccf 100644
> > --- a/drivers/common/cnxk/roc_aes.c
> > +++ b/drivers/common/cnxk/roc_aes.c
> > @@ -157,9 +157,10 @@ static void
> >  cipher(uint8_t *in, uint8_t *out, uint32_t *ks, uint32_t key_rounds, uint8_t
> > in_len)
> >  {
> >  	uint8_t data_word_len = in_len / sizeof(uint32_t);
> > -	uint32_t state[data_word_len];
> > +	uint32_t state[AES_HASH_KEY_LEN / sizeof(uint32_t)];  
> [Tejasree] This line needs to be moved up to maintain reverse xmas tree.

That is a Linux netdev thing, DPDK doesn't care about that.
