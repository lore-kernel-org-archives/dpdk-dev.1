Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A7DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:28:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14D140615;
	Mon,  6 Jul 2026 15:28:02 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 08794402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:28:01 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso5644777a12.0
 for <dev@dpdk.org>; Mon, 06 Jul 2026 06:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783344480; cv=none;
 d=google.com; s=arc-20260327;
 b=E/RQzZ43qpDuzLi9LXNN+5DAY2ddawgzRYJAf+luL30xdkmFjyCVcYtTq+fMufg5AI
 O+2sgGQVzW6Uex4vgrMO9iEVBtQa0USxKE3wLx63xRH66aO7KEfnzue4WoLZpW9oMIu1
 MRQcG0DAANgs2uEKKGWo/ZhZAGlUSEDp8WeIlt4JfR3yT3jiTHHZppp8ShW5eS8KVR/u
 5XY4W86/2Pd2HloGYuQdBB4ynDKwfRXxNG5OcV/cZpu7CnSQnQUeBvHREfI/sehrSA1N
 Rnn/16tM587gZAgzU+qziH/+/DbjZw3AQIpEh5XQvwOj7VVH/adAigZCHixcXd1KF/S+
 PLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SJMgYFXW8iXb/ia82k6yyTlZeHC2Pdb5fdJMuOYDOzg=;
 fh=FSlsNWNwv7lU5nl/fUyv/ErY0jhwYEexjlup5aTQPHw=;
 b=m6qhEx4pnD+Hjle2n+sVkTXAFkRPRyio+kc+lKER3nl9H2/+7XHTqjyg2Qg+iJKhn3
 LS+8DGuWA94nLaIM/Azsuo2zU+7xI9kcJ2tcNVvCxrnZfM0XmQWzZBjGKEaC0Nows+Bm
 exx3VjVDCZqxDH7QAG3N1otGG5tE6IGnGSASJtva2FFzgGPx64JvW+9dMIi47uuQimgg
 uBkWFq55+h4nrBB/kyluwyztdcf+jCZhxXXn+WcX5BlfrHY9+q3D7T8YkGcDuI5hJ2fR
 W6GKip1fj9EqZI97JLd3MSNBoJbOwnVKtm4i1srLGwoa1Vv3AaNofBqGrV12tpjmGOo+
 nO9Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783344480; x=1783949280; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SJMgYFXW8iXb/ia82k6yyTlZeHC2Pdb5fdJMuOYDOzg=;
 b=h+tuqLXTsMyJQrdaExqJo3IMlV3L/Y1LHJvQjaja4GZC7stopFtT0s3BWWIh7PRvmQ
 leusweX4Ij1JfmazQXTbXoz1ZKmpvhHllaCZxZUPT1OoiDDznlbQtpvbEG5ZSk9fECvE
 0gaUloPH/a30Oe9C/pynMLxb/K2Fwtis+lSbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344480; x=1783949280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJMgYFXW8iXb/ia82k6yyTlZeHC2Pdb5fdJMuOYDOzg=;
 b=B9L/mLbTocCc78NmQEquMbjwUxRVpXcmOdiHHUeSWmsL+GlpJPqSShlc419cM4xgiE
 jqewVeLio569w9U/VB1xmqKL9hoOe8d6njms3HnErDho6VBfkW4rQLs2cNCP1rotE+t3
 Mj+qDMm3LcUmH92hl4tlAWrHzDeO5/EkISbgnLMdZQSrr4edxXbb3UE3drvov1tbEzRL
 3z6S1WlwTsfBcgqwSmACTYlcuOS/MRi0T/GOSjaK1hYcXmx3fAC6/Xgw8XJEizXwl6ba
 n8QnddYESwNakZqyAzQ1dNqL6HONRAlVgnW7a9Q6u13m9dmiOFEteI9hRC4pceBqHxTL
 jEpQ==
X-Gm-Message-State: AOJu0YxKuskeFOxceAlEpREZRLhuqGqvHSZxBcA4P2bGWYdKVsXhYCLj
 kvlHcu9bITpawDk3PCajF5jS+0LKUA05C1rKmRSR9ixbew/o5XTigrg+TjDAXex4xIuH+Rfjj68
 QYUPUbZiKH0VlZqi+IAUncS1y7btALTsQhsEpwO+tgA==
X-Gm-Gg: AfdE7cmIGE5GwwH2KWiO4eFxNNRQEU5CaXi2REb2BxPFtbIU+lSOc/5UetNDIZt7Tym
 5tJ01w4LxgDxkTBEQ+EMqoKyXurcnWTbYSM7wS2tJuN6oWCjQFlLTNyfszF76sYURUzQqGVPi2A
 LbHEifTLWMUqiZtt+juBpUWTIVoxqQmb4Lb9qS2CqMkZnEXtpHn4vdMDk/qS6h2gdvHLb/Cv/tt
 5fhW8UJ60hPPZkNWqI8kFdINsIttZh0HzVPmKRZdpGSpfL006fVJtT48tc3Rgis58w2gJU5kRm9
 uHQrcdpnFS2rcM0q95XMLN+gOBf2Mw==
X-Received: by 2002:a05:6402:a593:20b0:698:72f3:9ceb with SMTP id
 4fb4d7f45d1cf-698c104c5a0mr4255669a12.7.1783344480612; Mon, 06 Jul 2026
 06:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260428181501.72434-1-abailey@iol.unh.edu>
 <20260706132633.465385-1-abailey@iol.unh.edu>
In-Reply-To: <20260706132633.465385-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 6 Jul 2026 09:27:49 -0400
X-Gm-Features: AVVi8CchNE0C_nYYiBIwpT3ceY0uBwFn4CCtwflqt0q6FKhgzyGtVLeufVDF9T0
Message-ID: <CABJ3N2Xkr3zihiTbzdByigibcy4i_txxCk-0Drzw3E1weze6rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: update parsing for cryptodev latency
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com
Cc: dev@dpdk.org, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000004787220655f13e59"
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

--0000000000004787220655f13e59
Content-Type: text/plain; charset="UTF-8"

No changes in the most recent submission, only adding dev to the recipient
list.

--0000000000004787220655f13e59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">No changes in the most recent submission,=
 only=C2=A0adding dev to the recipient list.</div></div>

--0000000000004787220655f13e59--
