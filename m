Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B089C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 07:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46AC740E49;
	Thu, 13 Mar 2025 08:57:35 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 719C140B94
 for <dev@dpdk.org>; Thu, 13 Mar 2025 08:57:34 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-223fb0f619dso12012115ad.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741852653; x=1742457453; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q64sgOJDSfV9ohzqJlkWBqTs1cOVZU+CL4Lc5y+jewE=;
 b=mtolC6iCO/HxbOXUW+sM1skEZFn6MnT1K/OQruLhgs0A2hyhxbGruu5du3kWSc5yKD
 KboKEfmcZRTVxUgd4J0dmz+ANiVSu4oeCstT8tztTrzfdiZlS7g9dcyS+HwdF5iN4+E1
 K3UMTssn83XOYC2x/m7wPsJYm97Yh6xqi7iRO8DUyRnl1QlN2cLMlRQ+ucDqFTg5GMPI
 iio2cR9eGaho9sEkMQbmeGjgnweqVDBtYzNoqJD5Mt3NlhUAY4a/HkMLCIjLQHb3fPU/
 J1KqhjY6goBkdsbX4FwDki4sgAnI7WIuEczEXUSP0KmiyZj0EcpQik/DZkXyun4vDKIq
 SjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741852653; x=1742457453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q64sgOJDSfV9ohzqJlkWBqTs1cOVZU+CL4Lc5y+jewE=;
 b=uehBdHsGOYP6KOCY/7ZEL8UC8jE1o7euL1z4pHjw5z93VIalQp/9t5h9Q/uWpc7cTd
 gZ2mER85HC+JzPvAOnG4H6fLbyg3GAyxbYFojoq5NiFdXuaz99r+lfyOYKm88v2ifxB3
 SX1hVhkjHKEfCCk1elSOqw+2Sdv/x2D3xlcc4jl7DnBxQAjZ4rm5Um4UC2AOsi13kdKc
 RMS+Om+zSby6+xshdF31Rwcl7en3fX9KWLsi7ZqU1tGaF0VeFb+imA6ZyJRv1Gsv/W+9
 I97mOzITu7yaViAZ0qZISItxDp7Hrc18Eikc4fTr/5i54uSC72heMkMEp8GpmYSeU+yW
 sCFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJgFs6FRODVUHCqdQYQRqGoqQ08scb9xTZBARLZxwWrAMDt8WRxzWeAiLVGtUJChGlCSo=@dpdk.org
X-Gm-Message-State: AOJu0Yxwt45G6pRIxrnhTzvO82sTC1QdVpcHs/O+juyBObR04+4A0dlQ
 EEeBOv1eSV0wYx+1Op59S916F/E02rhQv/RJo1jnOLOC/qA7QRQdsGzTa4wEQlFNbjCaxaoiegv
 VMPe7Sm2H/qxfhkHgclUPDeTat7Q=
X-Gm-Gg: ASbGncveG6anBcIHzgx9IcvSUKZnizVOHXWBYwUFaojQnovc3cW24Ohp4aKnT4Gz/Bv
 EO1hG2ofo2I8RRpVQBQQkx5crLYOwFZHfz0dHB927p167t9Yk0FNtxGijgT9ioZshUJn486aJNt
 9tzr3YpqsxxKg8Cs3UrpHhq8SOZe11rtmqWZsDLQ==
X-Google-Smtp-Source: AGHT+IHosm7xJgGI4MPqSx+nDmQ5PNCoX7qjIEMT7zp3BFAvzKjRffWsviDjSaeqkYl00gVEYh5mnIE7xxYYmDg1dkw=
X-Received: by 2002:a17:902:e5cb:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-22593184dbcmr129985395ad.42.1741852653480; Thu, 13 Mar 2025
 00:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250310091844.4a3ff0d1@hermes.local>
 <d380333c-4c47-116e-f917-14b101898e6f@nvidia.com>
In-Reply-To: <d380333c-4c47-116e-f917-14b101898e6f@nvidia.com>
From: Igor Gutorov <igootorov@gmail.com>
Date: Thu, 13 Mar 2025 10:56:57 +0300
X-Gm-Features: AQ5f1JqwvKKmYtsQyuAZ0M8Z8DWJI0XMZ_m7TZQ_0QAWq0-IDx-HisG5NbKnLmc
Message-ID: <CAL7bPf1wxMiCUQNhpavLZnWdaSQ-cj8nXjBZ4XDZubYaZ5gRFg@mail.gmail.com>
Subject: Re: [PATCH] rust: support DPDK API
To: "Etelson, Gregory" <getelson@nvidia.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 thomas@monjalon.net, 
 mkashani@nvidia.com, Bruce Richardson <bruce.richardson@intel.com>
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

On Wed, Mar 12, 2025 at 5:49=E2=80=AFPM Etelson, Gregory <getelson@nvidia.c=
om> wrote:
>
> It's not sure when and even if vendors decide to work on RUST PMD.

A PMD could be software based (e.g. net_pcap). For such PMDs, Rust can
be a good option.
