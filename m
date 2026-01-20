Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68569CA5FB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 17:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54BB041060;
	Tue, 20 Jan 2026 18:29:42 +0100 (CET)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 9399740ED9
 for <dev@dpdk.org>; Tue, 20 Jan 2026 18:29:41 +0100 (CET)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-78fba1a1b1eso992177b3.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 09:29:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768930181; cv=none;
 d=google.com; s=arc-20240605;
 b=ZK8L++MlfrC+p2DQqzGvN79PQFkL9Znxq5PGl1tdxsrU/ouWnMloHjY0KlIRthUeC0
 YFe5Vx9leQd0S5w+5jeN0uvdvIkRT/78cUi2bJM53x6fuvK42t2SPnaCJCRLipvyIzOk
 0wCClrv/VTk5SqDA5LEFrER2hD+xu5B3Ah3Xl+Fi8/KDmCwkEDkZPOHPJA9mAuWX/BsZ
 IC3N5c0ckqEBlcpNWDND1G0waUl732FB6oawhukCCBLUFoZHTXtiNMGgpW440sbufznu
 Ec3xQqZZzmbBGCNaXbddQaOCrI0JPpm7k6V86bfdpf6vG+MJ97D3G2yLThyJe6y4khSd
 4wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fvZ2uWhuOHzuEHVL6vIpg+ys8McqPzWwA7GQ7qdN1DY=;
 fh=8mEoBSOKgbRAMbLmRyK1rHNzpC8UhXOh1hUZbUNWl24=;
 b=NHsaNm+GeNsNxhFKqp9I/PqJmddH7hbNmYLI8p+9Cc/9AzRQD/HWCtuBBjyhaO3q05
 1GtQ/xSwaESrZEVSYuNDs77hNSZA8ELmXyccL9f53xPopNKWKZoQQT2px6Hbk20nIWuX
 CFHp59KXasRup94tGDSksacFg5yRvioA8DTAmILuwxhzeI1+89u1P87nZwD78PglDgIk
 Mp22YMCe1G5zMhBx1wjI50y3tpqiEBDlA4koqz/+1KKQZ+lkZCforZ9eEJPNEfs4iFTK
 16XQh6V0N2250kFMWUrHKzuVwfqGrqAl+av4sEZXD0X4GvjJSqbIqfoRTx7xk0o2ryLn
 oNxw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768930181; x=1769534981; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvZ2uWhuOHzuEHVL6vIpg+ys8McqPzWwA7GQ7qdN1DY=;
 b=Gp2yxKDuMP07Qt/5vG2IFURm21txaF0xyJT3Bou4c6NRsDkYp83eYd1hEqeNLwOT9p
 x5YZ1LBwHHkFwtE+fxnBvnLln4l2Z5GnLVr9jMsMQYKPMATd01YJFzfOQ/lkczdqbsHu
 iKpO6StaFdqKPKhJPPJv5E/0YyTIS3VTFtl54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768930181; x=1769534981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fvZ2uWhuOHzuEHVL6vIpg+ys8McqPzWwA7GQ7qdN1DY=;
 b=eQVC+7mYgEWVhG7GHbPA41ic9AqnwM4mHjps75b4Sp+XmPzLNIcMIc/0eh0ceBgXP7
 TjwNvUJ6SVcwRTCariABMv1lXSDyH0+I4fFbM8AE5tIUmLXbfepv2aAht6QhRzD58OOK
 TTIAz88TbjoSsTiekdBIRjAbEu13c2VMY9ASt1YVxcBGKoFAzHgO0/MoMhjWQrbDBOew
 Yjtb5JTagtkhOrs6Obs+H0Lo/3CkXVx5MwFc425uNrPova72XAgZ64sjVZkSAjJTuQG2
 Vwt1oC0DdSMAPyQzeM1ypvXtCjFaX9L5udRdoNihftUNyAu2f/Qd7WEP/W5hRCqbU2AK
 siFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxjtMaBhorMGwHv87+1VaVcTSOnZzNQBJ6rppaM2IcoUNXqet01ZMu3u+A2B80jjHNVYM=@dpdk.org
X-Gm-Message-State: AOJu0YyGqj/XGHirbevUQB/m2qLn/tRkyy6k0lwvMTmoQ9HFeVjCm8b7
 8+Qwd3A5P7AoiInN/CVZVIydE4iEa+UB77MQ4kEXzZ3TF+U7xpzXg7qRzjgt4vePa+g2ct9fvBU
 /uVV4SrsU6NaAY/VPmt8KYNvuPjgxI17oQy4auqetGQ==
X-Gm-Gg: AZuq6aIw737/12nq7ZLVvgzcjJZLqi23Xw+JO9j9u2ipZ+wZ6qWso/qBhSEOjZaiJ7y
 rgiGv0d6hjEITwIqdG00+IMjMnAkpqG8+dqA8JK0TkII1DW5J7q9qelVlonqJOPtTDncAY3OZL8
 yPgJP7BRH5oUNAxUoRrYuPdoMo44YRhtiO099ZEYvqskfPanOBjbO1qRxUTaspe2/cxuazuOyuZ
 QsUQaNK+P0wXHkXEU3az6rbsBWyEonyC/dvUYpHlOknE3P2lqH1+nH/tmqZYy6djKVRmT9B9Ouu
 ZSulqIrcOA==
X-Received: by 2002:a05:690c:a708:b0:794:914:d6c7 with SMTP id
 00721157ae682-7940914d863mr16913217b3.18.1768930180937; Tue, 20 Jan 2026
 09:29:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768518003.git.sismis@dyna-nic.com>
 <366f384e90cce0867652231494d8c873066b5fe6.1768518003.git.sismis@dyna-nic.com>
 <CAJvnSUAdWtn4vo_8mGU1T59U4ryVm18nnwPy-V6hYNmb0rdeyw@mail.gmail.com>
In-Reply-To: <CAJvnSUAdWtn4vo_8mGU1T59U4ryVm18nnwPy-V6hYNmb0rdeyw@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 20 Jan 2026 12:29:30 -0500
X-Gm-Features: AZwV_QiVQ7j_s8mPv53h5V_kZw5zAdXmbmYAlLpMYWst0W5sxZSW1A4bE9Lo6pc
Message-ID: <CABD7UXOv0cCUkP+oLPk66MPJ0PCaAfznJWkN90p59SCKkdfL_Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] dts: fix invalid f-string syntax in testpmd API
To: Patrick Robb <probb@iol.unh.edu>
Cc: Lukas Sismis <sismis@dyna-nic.com>, dev@dpdk.org, stable@dpdk.org, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jan 20, 2026 at 11:55=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> w=
rote:
>
> Looks good to me, thanks for finding this issue. And, since we do need th=
e 'enable' strings to be templated in right, I am asking Dean to re-run thi=
s testsuite with your patch applied.

Test suite passes with the patch applied
