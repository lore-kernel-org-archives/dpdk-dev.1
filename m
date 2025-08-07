Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51659C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 15:14:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A83B4027C;
	Thu,  7 Aug 2025 17:14:08 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 219D440270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 17:14:07 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-31f255eb191so1201964a91.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754579646; x=1755184446; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SmCh091qJO4N522xwDCfLt3jpBwnSMShSXIAxLMmhIk=;
 b=D7twmZsPVHx/6nXzPc0p6GxcFcjiTZcYthAn7NuwqQt49uRfoyy9WFlMxASb2jnz1t
 jfwiZBccsZyk1VqWHQt/pW7s97DRT4cI1Fc4hPAwTFL5I80C2vrGVjLAw5VcuD2mdVQQ
 YBGWfpGjdZCUxYmyQ4d1W8dfIomsdhvf5aTnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579646; x=1755184446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SmCh091qJO4N522xwDCfLt3jpBwnSMShSXIAxLMmhIk=;
 b=Jg+W2iMfP18etn94D54Jid50ctYadQkgw5wM/k8KWp0tnKZ8RA8F1t6YjwiFBqiMxX
 utNWVrJY46IdMogKURvXT11I8Tds4KkhCsHLo5mGgz3VPTGpx2UsRvyPv2E0Lini5FQb
 WFIA3G88dGeTZK9S7agYaKiC2Kko3StTHlwPKuMvtgmqje7uyvmWhKdDKReeWLcoXCeq
 7mZVj+bpfOD9lprgoUZ4HQGhXB8zAiveBIcRYP27QY4D9bXlSyM7lbAzKsHEYdgWOHAa
 QFJG82FAjiq7EULXpfgVVD4ZAaqXmXyECgCM+EFWrNgCQnRdPhPhjKaVUI0V999h+pD4
 sKTg==
X-Gm-Message-State: AOJu0Yz7WkE3OO8QPS9P4T4Scvt5/RXh5efE8oe70d0RJXEzXOGJez5Y
 TNZIMqI5LtcKz9cL8WIrvoNK2SztJtKhpFKxfZo3SqzwGwvZBRq9EjW/3Tr1B9KjTZrOonnSjgs
 2TInc/q/1CpPVZW9KwgwYu/4VeIQMnoaF1hLJ0NXCZQ==
X-Gm-Gg: ASbGnct2GuMoa/bZ0BmWSh4bC0ELlxt5DwF3si6IrIMYfVFRvlZtT+ZlUn4Z7Y0l53Y
 otBoso4thjpYWn+hWAy8mvcnWdMXEvBOmHVKfdBv2HhDsB5W59qLolo+ZcULDCnqOW+rhlid7iz
 saijFYOsfqAi1YhFQv2MotDGU5673m15SEbjT5YdfIuEuCp1qXQnwkxLzo4LNfiEHb1WKyZZLAh
 5WaccOyIymlYdgEgu8o9kQcbN8EFfKk0bad5Jpt
X-Google-Smtp-Source: AGHT+IH9lS8RPeG82DVedZYMxg3EmS3Cssx+pTeRRfntUVmgLxJfUTty6McOVeq8HnT+Sm/6e9epH/bXI/nBZbX8AGE=
X-Received: by 2002:a17:903:1b0d:b0:237:e696:3d56 with SMTP id
 d9443c01a7336-242b1a65354mr67610135ad.32.1754579646210; Thu, 07 Aug 2025
 08:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250807143019.1986881-1-luca.vizzarro@arm.com>
In-Reply-To: <20250807143019.1986881-1-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 7 Aug 2025 11:07:50 -0400
X-Gm-Features: Ac12FXx-IuyBnKM2ZBcwNo_VFONTn6hsjaUs_KbTbutgxq-LjXkMVAU2I5AiTMg
Message-ID: <CAJvnSUD_DPxRryK_FcdZrS4vCikvUA+75e8tKtAcz9_T0BbPmA@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update for DTS
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Thomas Monjalon <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="0000000000008b052c063bc7e828"
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

--0000000000008b052c063bc7e828
Content-Type: text/plain; charset="UTF-8"

Acked-by: Patrick Robb <probb@iol.unh.edu>

--0000000000008b052c063bc7e828
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Acked-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--0000000000008b052c063bc7e828--
