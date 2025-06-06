Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC3CC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:00:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27F6E4014F;
	Fri,  6 Jun 2025 10:00:01 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8737D400EF
 for <dev@dpdk.org>; Fri,  6 Jun 2025 09:59:59 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4a588338015so29129241cf.0
 for <dev@dpdk.org>; Fri, 06 Jun 2025 00:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749196799; x=1749801599; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DytWbMsP/Avhut3r2a0R78DHlabH+0pvJ/wqN6Sp6iY=;
 b=hpTVSGBtSDJEuzBzEzSnooM6PP4ODrDM/VEJ7DUXt7H4IIR2hyt485bTOj2eeqxHru
 TMiyVkkqFNHU8kLMd46Ry5kAeVYgpQjxi1PdyWQnQ07RX8LP0yn9y4vMkS39Nw3MZMnk
 mGYwHJVF98JSgdMdkecL2VSq3o4Bw2Oi76wBWiXEmCUDRF5IUz55Oyp1CeqrJUojYLtx
 71csWaHelosm2wEa7PFheC1bfDbihCybTbfgln6eVbxGMdFvYQISxVzkeXdv8DF39/mJ
 v3ZCBKPtroWbRTTruUFcS+NTBFcSrt2ZqXaR6MwzuLxyVF+av2wECbpcQq2WKN1lqboj
 jhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749196799; x=1749801599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DytWbMsP/Avhut3r2a0R78DHlabH+0pvJ/wqN6Sp6iY=;
 b=oUUeYxXBxF+O7I8jSzSlA+imUA/6UrUHTitKvpb+j1oxJJGC0WuRPSD+45H2YNHkkl
 QBVZ0pvlXh/3yeBrM6SOuMOEsaJ1dCKBajHrgzxSq8FY37fa4ZTGewtpnJkctKRTmIFE
 mSRfb5V7ABVvAAKNzU+6Hdr9Ns+WUVCT0ATvjNcZK5ttMJcXXpncz3iAghsXDgrvAKmM
 PoT0deUMIBFgXHbMKhrbjX2Mnlp2cg4Z1ltqIj2R4QGtk/Jpp2K7ZEQHiVX987xVAkW5
 jGUWwyLpKNpdP8GgHvIzZOPxW2MHFYXoB4JjB4B7Yidgej2vax26zkqRkN7vT8sku30a
 jhsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzi8jQii/FzpXoUd8+oNxG1TY/56LXQIdeA9IddEkZkJ7itqPiZRTepsBhNyjkWAktoLA=@dpdk.org
X-Gm-Message-State: AOJu0YwUJvnkKxUkDvS8urwxtfUFi4o9ypLv/FgF1mLp9ow6KK4kjN0Y
 MAKpkdbL5rNfdaWfp30RQ4Hg+DrEkALCjUvYY80qnl6JXME71xGTom3aX5T2YxaVIddnV4NWxws
 ZN7Z9Ilg2jmsJtprBNRGBzjhd+bxyQ2w=
X-Gm-Gg: ASbGncvsADGf9e7qYvb3439GRFk4UcnIG/OQhhbs0JvidhKkVlOKo1dmv9ZD/vFliSr
 0zz7lNDW+bNFak6+55lrApUbtP/CVPT7Qz5QBeWBNe44NA7pO5TUuMmXid3omgVAu4HzbKsUW3B
 yJXkOwSoi5d9GeYFh9DV8NbwAhPtIWtwo=
X-Google-Smtp-Source: AGHT+IH4KDVJKa03PHUNuXdIDT5opXtssniksKzH6JHssJIX6NWKIr1maNn1W+0GmlWKeQpQrOjEryVz6uNOjP19doM=
X-Received: by 2002:a05:622a:1c0d:b0:4a5:8820:a0ac with SMTP id
 d75a77b69052e-4a5b9a04a44mr40113361cf.3.1749196798734; Fri, 06 Jun 2025
 00:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250605173315.1447003-1-nsaxena@marvell.com>
 <20250605173315.1447003-3-nsaxena@marvell.com>
In-Reply-To: <20250605173315.1447003-3-nsaxena@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 6 Jun 2025 13:29:32 +0530
X-Gm-Features: AX0GCFtDcBOAM37_cGO-ty7I4em7ZCyoEHAAZdgd_0wtqmZ-tQmK3duWetudUSE
Message-ID: <CALBAE1OfOQ=ui_xwXWeRf3L3ko6bmFJDrQ=cdMWj=XOjbTAxmQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/7] graph: add feature arc registrations
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
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

On Thu, Jun 5, 2025 at 11:03=E2=80=AFPM Nitin Saxena <nsaxena@marvell.com> =
wrote:
>
> This patch defines RTE_GRAPH_FEATURE_ARC_REGISTER() and
> RTE_GRAPH_FEATURE_REGISTER() constructors and associated APIs with
> programming guide.
>
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>
