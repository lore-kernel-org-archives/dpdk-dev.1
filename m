Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ABDC83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 14:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 482C24028C;
	Tue, 15 Jul 2025 16:06:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 075EC4021E
 for <dev@dpdk.org>; Tue, 15 Jul 2025 16:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752588390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=BGe8ruwWUUv6y+xWD6Dc7fkT4nYFOYXdv3w35Wepiv8=;
 b=Kkwb8GZhWMMGR3h9DUGQERTiCrTQ7F8WcYuEMbXq8GrtmmPHTD5abDu3E+b62+FdSny88b
 lkca1ZMepHeQC5tDX6re6Hxrh7pIqU0Yngm5DeXZ4hMNdg6C1N5yNZYX9NadV/sKEcS6vU
 8oMoC7VMsxI96VZ0HjrhEIkGslvbfYg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-IYJCxVLqOn-Fwc9CQth6yg-1; Tue, 15 Jul 2025 10:06:29 -0400
X-MC-Unique: IYJCxVLqOn-Fwc9CQth6yg-1
X-Mimecast-MFC-AGG-ID: IYJCxVLqOn-Fwc9CQth6yg_1752588387
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-558fa7eef58so2435913e87.0
 for <dev@dpdk.org>; Tue, 15 Jul 2025 07:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588387; x=1753193187;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGe8ruwWUUv6y+xWD6Dc7fkT4nYFOYXdv3w35Wepiv8=;
 b=eGS2umYgPwhDd3rB6L4+7ECGK0xwkD3LocpS/njF0ivxhJ11H1fQc/Kx7i9Ohj+fD3
 b4ihJ7u76je2H+JmFF+uxN8n0vUow17KUAgsZMfsGFhGU4LpTM7qCQNECT+iEFYcQn2U
 r2E8FJxV4IP05FZGExTaAcSDgqxsqLA3jjYJVYj4NpMzPclx2hvjLCKn3hOgYE8AJAe4
 jd53TqARr4WU1ggePpYKtFJoRbiBQ2yA3lEU1NLlFydzJYqQ7d2XoVaLu4v82uu9Y9mu
 /WNjD2ob35UXfVjwQv6Cihwpe84C0PrmdelFjG1dQ1tRZYAa7TxrZtUlka0q6K/caJyE
 6Ueg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ExroCQkmrzQd8oLWHK+yoTLkRmtoxxzLm/+fzklwy3nF4hrHcQick3BzGPskNroER+8=@dpdk.org
X-Gm-Message-State: AOJu0YyHyy4GYrpm6CGMuGxXikv89C69etK8xuRDND9teyDoy7nDZSGA
 zkSIqgXRuiuXtoZtzPPbEIilYVboBfmhlJWUKJGSgMCECCuL8HH6rV27V1NpdKJYGEPz/qFn1Rx
 zxBG3NPtVQspMXGL/Yj+z4A4MRRLYat486OJ0GGYZ1pEXfwRVwootAJRUGdj4X4wDiu9L6unE2n
 dzyxpzVqGP6aM8ePXB7G0=
X-Gm-Gg: ASbGncuYizsb7bglSpQ3xgl1Y/OOcOrEjntlCR7NTYYRpO5C9aF0xDEntqbNF3qThMI
 1p+D/Rybo4k2wLlSbNn8MziicumLMU++7X2XL7tENU9Z3uW9LPH9PCN+pUP4n9tyuEopZhn4/Xr
 mFwc0U+Iv++ANfs5JRWz0dHIg=
X-Received: by 2002:a05:6512:2392:b0:553:cf7d:72a0 with SMTP id
 2adb3069b0e04-55a044dd744mr4888368e87.5.1752588387269; 
 Tue, 15 Jul 2025 07:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8mkz1Qg06pttMN8y5i4xcaxPaLzItBUw1eqjqWggWhDmGmULRUwfJoe2mAoOdzuuZCBwrR2Q7vDvEcHiw1hI=
X-Received: by 2002:a05:6512:2392:b0:553:cf7d:72a0 with SMTP id
 2adb3069b0e04-55a044dd744mr4888310e87.5.1752588386523; Tue, 15 Jul 2025
 07:06:26 -0700 (PDT)
MIME-Version: 1.0
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 15 Jul 2025 16:06:15 +0200
X-Gm-Features: Ac12FXzPB3q7J8uCfmbnzCq9vmIcBRB_wIahqe1x9Rh9Q-w4vaKSs3dNXXLeA88
Message-ID: <CAJFAV8yKjHSXEuEMYQ4q3pcBNe0F3aZStaJQYnsud-YtdjGWcQ@mail.gmail.com>
Subject: Need reviews on deprecation notices before 25.07 release
To: dpdk-techboard <techboard@dpdk.org>, dev <dev@dpdk.org>
Cc: Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AL5Jqq1wVkQEygVEYKtT2-8UGaI4cwGuHWl0Z6WqmSA_1752588387
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello techboard members, all,

Ping for reviewing deprecation notices before we release 25.07.

As usual, here is the link to the bundle:
https://patchwork.dpdk.org/bundle/dmarchand/deprecation_notices/

Thanks!


-- 
David Marchand

