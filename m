Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD1FC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED18642E71;
	Wed,  4 Jun 2025 17:47:39 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 3AD1B42E67
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:47:38 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4a4bb155eb1so53490301cf.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749052057; x=1749656857; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uy8elEagdArrREC1nZndXxkaXHZUT33oB70ttaOa/XY=;
 b=GkVfWwuwurjq9tgx/7eUA4RLcDrBrh5HcxxWMdjmrbnjHRaKJC/yQ3ktRVUWDSvsNe
 UkBT01jstAL9YIfgp+lgPrDvnxFflpqk0y5IeCrHPc/eiFyx2T+ZayuWYq8MUts/63qm
 u+uhfk4Cm6+Yq7UBsMcxReeXCZyIV29HLgermQss3yX1gjQTIzEMHzqC7qEELZcGiXbk
 hMaIy95oPXq4yxufv3JvPtibgVbQZn4prgVkczQNZRVUfcc4aF+lGNUlPVvvBMV+c1UI
 +gSu+Ia5sQmqMgab1Oorw2zdwjQbGb9YwJrG4FQoHGk7rFO7RxTJvDk7YmuH0P2aPgDw
 rIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749052057; x=1749656857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uy8elEagdArrREC1nZndXxkaXHZUT33oB70ttaOa/XY=;
 b=OEICoV5gbRk3LSewqBORUx+1I+qPos787FJ3A0n1FSEnHf71Da3oJctANHoi3yj/MV
 N4Dst7G8zelFvZW1xrQudKdI1E5u5yuSG9DRUdseQGUi7O+uWCynIpfk0AG9e3YLj3nk
 +yoo/MRslaAVCabqKo/hVht5QnNzWSW+xJnvlut60YL6gWpfg8KmfgxjfxBvzax/7Tgk
 aqJYKRMM+XXaUii0XhRdZN+b0Nrft5YpWLzmdk4tQD7zK+o6flg9P43NRf4bvzfo8+hs
 22ZvFvdZVJFh14SgA7eGGKZ/30hTQ3QURSDq8LzM4LGLE576xe5sE5sylPJO35jS6CC+
 uVFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJGzJo6AFlrQAVke5hIjfdw7gk8NbavqdHJ29jM5BJaA0TJd4zZAIRtf9mVyiqEDWfuGI=@dpdk.org
X-Gm-Message-State: AOJu0Yzmk2i32wQ72kvj+Bjfrarn7U24oktjkDIEbvhqTRszgW65M045
 4rYeT3aXvRDvFIh0jFqE54QKFdMTYZyXLz1hJVwVlZNWDilB5xtnrUCR/fQj13SmGpumtchjv/o
 Scc50F5sHJCsHgY8C1MoxZf5VIwZVWqsN45gJ
X-Gm-Gg: ASbGncscWez9HgH/qr0pwvWRS+OJ2k2xDK9ci39QXMn36OHX6duEBEI5onYhD3Bbyz1
 noQFVjDYxwX/jhQ0BQx9l9sCzEWwlPjL+7AXQfgc36zKeMTCDXHLO1OtdtMkcIzk5hBqICqtShx
 YBznth+UvqA2sY+76uu3Ug0/h+uk+2CXpQBPn3hNauk9UgigEkiVx2
X-Google-Smtp-Source: AGHT+IGGayJl1ye3wLdKKHaAD+P68L1wtpiLW2lv7tCSjDkB1hPe8OdutMKwGOUR7IemdyjbLZc+jqHJIiVqPGfT2yg=
X-Received: by 2002:a05:622a:4815:b0:494:b316:3c7e with SMTP id
 d75a77b69052e-4a5a585f38cmr52827611cf.28.1749052057469; Wed, 04 Jun 2025
 08:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604153020.92712-1-nsaxena@marvell.com>
 <20250604153020.92712-2-nsaxena@marvell.com>
In-Reply-To: <20250604153020.92712-2-nsaxena@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 4 Jun 2025 21:17:10 +0530
X-Gm-Features: AX0GCFuEIWeDg9uZhdaJoXBUXMG84lemCtypTaR-6fPkGaSKeBgSkCkCjzVCN1Q
Message-ID: <CALBAE1PgxCvf5cdJ67sBiwR+62DDqWkQT4n98wirc=U7Aj8T4g@mail.gmail.com>
Subject: Re: [PATCH v11 1/7] graph: add API to override node process function
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

On Wed, Jun 4, 2025 at 9:12=E2=80=AFPM Nitin Saxena <nsaxena@marvell.com> w=
rote:
>
> New internal API used by feature arc library to override node's original
> process() func.
>
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>
