Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B72D74EFA
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:20:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 265F140269;
	Fri, 23 Jan 2026 17:20:24 +0100 (CET)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) by mails.dpdk.org (Postfix) with ESMTP id E5A5A4021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:20:22 +0100 (CET)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-5eea9f9c29bso1804974137.2
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:20:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769185222; cv=none;
 d=google.com; s=arc-20240605;
 b=HqaNuaRmw1nO38oVEA29H5qxl7yHECQjGJwk/DyZDLxtYiXyV794CctfYWfhS94x2b
 lz7Cer+R63Nby7ZlFBJNDzFiKrx3E4vTzBkRGcunQvGtE6eZBK4wKpio9pXRsAuEW0J5
 uuYjBTy+pu8GEGb6vSV4JP0ACAjhNqo3sYp/h0v30IgybQg/S/RBEjBUbIJIFd/+kppx
 +vbcL2Ldsl0Ys8C7Re4uSCjLDWJDIJQ+HldCRZA8sE58Vily8K/mmFwHKIT2iCr8QNzp
 O3BZEepXI1rau/GRnwGPL3O2s8faNkQ+a9SKuOvgWxNInJpCm2NrHDlej5XYdGFzTsCV
 VEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BpCDEp8SGjfkvFhGG3SDOJ6ttAOsBOSeu/y0/YkxIcA=;
 fh=+LGJwwofMCt7xUXa/ZNYDESi6BYpN/S42P094EV6/J0=;
 b=dVw4figMIRGmanMLiWzYX8K8gYChmZ4xYfadJdEjmuYXSAfOGHwS6okARCr+obi+fK
 WtbO9fpaEh5Rsf9wil3PPB0hphVvNn7e6aVTKkiz5VFdHlRHunC5/Z6ljb29drjt2A7L
 LiJ1WtIlMbk2vz3BE3gveFI243j7SH98u0KR8WPbPJGrVyaJzkiA+++qZvc4UgiUX7VT
 slUjX/O3/gYDX2PV/th0nfDRUGcc4OjzHa9bq0l5Tl6txHTC3LqdW10dMupAqIBN7zIr
 Yjey8kpfimrJIlEeMFbehiGHeYpWtjxtJMxeexYf5L27j11jnX0GZHrdxhdTHoTiF7l5
 cBWA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769185222; x=1769790022; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BpCDEp8SGjfkvFhGG3SDOJ6ttAOsBOSeu/y0/YkxIcA=;
 b=CAN9rILU6tBHEOzeXot9Tfumh51Wh4PCY4c6dFHtv8aZil0dN7xzmb56nbHRzeJOC9
 UXm4U5IkfY7bl/5mXDZ6gh327T9GFPim4qZ73SnZ6CTP8DMWEsGIJTT4g89x+vu77eCw
 UtAbUqhAycj6cCz0dZOuW7WVU9nZQcjQp0MXlaX7qxNAGb0YP9O3WxWbkE7/0GTvtV2v
 LnERKpzwpiDk3OZ3MUWXL7gymrOmcio+Zgmw3BPZKXryGFciTP5Y2//LtFu4ro1MLpL7
 Cmiyxu+BCwFRB2F63JRRy45Ki+vNzChjgZ89bxx6W5FqlXM0kMSvZFctOORjlB5IB+16
 L8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769185222; x=1769790022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpCDEp8SGjfkvFhGG3SDOJ6ttAOsBOSeu/y0/YkxIcA=;
 b=i8zN+6HWtH3cuHHNsCfxUzBpQZdFgxq7U84pXi65hZF291pjEd3QZZSMBiG7wMcGjM
 ZrmSCkD9Itho+tdUThYCAfYCVqYMkuqdzGeexUQQThwmu+B9poZMw+Z26fHALevzu7eh
 0liqhHdTf7UqnM0cuKQXli+/K4ziLy26KfWg62lIGrOuM1NRZjJulakO+ioT3gdYEXpF
 kIEhCToiZgSZVvkUztFl9pCUXH7LwimesKdx6kR25yY96qcpZZ8QQFLo67KaXAWbYHQT
 h05Xm8gX48/19ocJrT1OVXBUys7zEhGRzPjebkazP7thahLwjVMI+EYzvLLw2F5Kcz8I
 cxyQ==
X-Gm-Message-State: AOJu0Yxt5Qtc/1Dj5ODZYyWo0iqnBesTi3poZgSkYMlcO/3tlpxtkKUF
 g7MUlZ65qlUMzu4afFBlaQJhZI3ZogQvnAHGmQkQOUoEaRjQgAdcbdK/M+PHpldgOpNgrZoJI+0
 dlBbU+DFmU7nBXuDJ+0JkuU/fx9Cauz8=
X-Gm-Gg: AZuq6aJeSVrIHdKv8lOiNticsgbeL8QLxA56VV3hHqF+wpbQgPF1tpKPXaRhfi3S7Qb
 dg3FmjbSXYNLuRj4KuKMM2MLGuBfwt5v70w6OqwTCHMXH2YS+V78tUesRqnRyIBnWlfl+22IRtU
 d4O3yVoQmU+4Xnjtx1WO4KxYuQDtcmHZm+Arjr8RDmd7NOD/mgjQWjnTsZO5k6UZwY1PIXOb4P6
 XRD14WltlEFn3PcgvmmwBxIHnDcemO0RLOuAMg8R/FhFCHfaPCo8Ppnf/5IBnsxtLn3AHg=
X-Received: by 2002:a05:6102:e07:b0:5ee:a0e6:a9f4 with SMTP id
 ada2fe7eead31-5f54bae3d96mr1394009137.12.1769185222287; Fri, 23 Jan 2026
 08:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20260116231907.13895-1-scott.k.mitch1@gmail.com>
 <20260117210322.5419-1-scott.k.mitch1@gmail.com>
 <20260117221211.57755069@phoenix.local>
In-Reply-To: <20260117221211.57755069@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 23 Jan 2026 08:20:10 -0800
X-Gm-Features: AZwV_QhQiMq49j1VGNijHajBXv7GswnehuVeGt7pD-sUTTApjnSgVJt3MIlGwac
Message-ID: <CAFn2buAYka1jkaAzqGRm531uiJpiUXKgzLAJxqRzRh3XDyy26A@mail.gmail.com>
Subject: Re: [PATCH v9] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, mb@smartsharesystems.com, bruce.richardson@intel.com
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

> Ok, but if you add more tests consider using the unit_test_runner()
> in test.h. Mainly because it makes it easier to pinpoint which subtest is failing
> in a big test.

Sounds good, v10 coming soon.
