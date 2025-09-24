Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B36ACAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 20:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C3BE40658;
	Wed, 24 Sep 2025 22:27:36 +0200 (CEST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id 09ECD4064A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:27:35 +0200 (CEST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-62ec5f750f7so284160a12.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758745654;
 x=1759350454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWqKuoZtj9ctV8OulGD5B9hM3F0uXduGsF1wM0dnAEI=;
 b=Wm7/bJlIoopPeQxPSU3eyc1/GMj8235takbGP2KZO12bEk8EKc8MG/SXfc2gtn6khy
 4GCtzPT/Ob+K6VkF2AtPltxOJrOnbMMY6JTS8zNcXAGWYnZ1XOfnYIPv6RoJH/N1vHpO
 o/JTY/DoRjwbBpxA65IxjyFubpbpGwL3KbYLXicsyzxVRBXH+v/DS9WzhGdZu3Lyt4Os
 JyX3WX/r8fxFRzoJTg3dOrhwHc8WDq6b49XTp6mHk6Gup/8lQz1pp/FKXK+p16BLj3bI
 ylfNeJg0xWWyq79raKsi+qpthEnkCG5FbGU9VCKTZ71/2y9LBvx9wnMEIs/wovVLrI42
 OqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758745654; x=1759350454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWqKuoZtj9ctV8OulGD5B9hM3F0uXduGsF1wM0dnAEI=;
 b=qZQPmxZPz5k6NushwhlhjQG4ssqU8sYRFpP3kEDFBL+1d6Yc9W5jETU8+XbuiogA0A
 Nvzd5ixNdmwRS5O9ERzMJOP7TL9YySJPperLZiprmEj4n7gUZKgjgHSgKkcHYq+joOnK
 bP9gVctSaqVQ7wt7mzM27uZ5tB7wBW2Kqu/eXqeaJzG8S/qS1eML8dNZgRia83L0GYYQ
 DMu/naNciP2Mi4paG6qiyQ0S6lZA1zH2jJgkd9ssJfaHgvM9C5rN/KIq8iINhoCACVLE
 HBRlxWe6p2QKx+4lsVEcWdh70pYvFWDQvLno9n9zQwzkeDkez6PfvC3fgGRPg63x1yEM
 TLQA==
X-Gm-Message-State: AOJu0YyZYchhi6LmZzRUjr83x/g5+VwdU7xissiOUnRH0On39Cof7nmM
 J/WjJJweaFfYCWkwewpl2W3Cu0rhN8PDLTTCv9BMg4tQmSBNbPSbdcLyDIbkiNUtSDj4NyISNV0
 m8irW
X-Gm-Gg: ASbGncvEvVdDTQhpEQMK40WKaZOUl+5mMqMawbCizI0Uu73GmlExYYveY9h+u1D+Do8
 RXN1N0uMdpSinqI8LeLsWfewrpu5Mo6IxDLtysORs3aoV6qaXyBnlYRoFc1274325rr/ZgJasG/
 +SF71f5NWDXm5wBwJrHIVzjvaMWMDbjql93PYqBi8M+oHc1c3neTYzY0kmF8InXkOeBmiVjDUTj
 uKNgZX/T/wp5YNPMr8IxvkgVXkWhMYdeJRAvjKf4Ns8knZUii6o6j98Cq52W2csCpMEZWBD5rDJ
 KRADNxDTIm5prmnrNSp+OUOl4jylHZAuYPKzYHGig+OtfWh8V9ZKQ8hY+HBE3Tpf5CvzOIHdeQ8
 ojGeXjzr1fQZdPKiCsH+kCSs8Smk4jU5zaGQR1ppwNZwNeOoKHDXsqyWNM5WCZPpBA1QAAmN5o7
 A=
X-Google-Smtp-Source: AGHT+IGd0frJJWDiUFht+XAC+Garnm0Ioba+jGwqBbRMAxfySI7AsRg4F9kRzKOeugmUBY0a8553Tw==
X-Received: by 2002:a17:907:6091:b0:b1d:368e:3ae5 with SMTP id
 a640c23a62f3a-b34b1e7b1fdmr100558266b.0.1758745654303; 
 Wed, 24 Sep 2025 13:27:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353e5cfc0dsm11558266b.10.2025.09.24.13.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 13:27:33 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:27:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 1/7] net/ntnic: introduce service API for NTNIC PMD
Message-ID: <20250924132728.35434e87@hermes.local>
In-Reply-To: <20250908110446.1071964-2-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
 <20250908110446.1071964-2-sil-plv@napatech.com>
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

On Mon,  8 Sep 2025 13:04:39 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This commit adds a common service API for the NTNIC PMD,
> which includes functions for service management: add or delete a service
> and retrieve information about a service.
> The API is designed to facilitate the interaction with services within
> the NTNIC driver, allowing for better control
> and monitoring of service states.
> 
> Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
> ---

Series queued to next-net
