Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CCEC87FD2
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 527CB402AB;
	Fri,  8 Aug 2025 18:10:51 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 3B5004028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:10:50 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-459d62184c9so14289385e9.1
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754669449;
 x=1755274249; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pF8E62wU9J+ASfzXPn8bcStUaHINPlKxsqQ7ZY+44hg=;
 b=HDv6ZrXL3t4kHvsOxMCjv60OuW/sEUg9xcKOKUDzpC1AxjnoAoqCZPQtci7sWAzG4p
 s553L2bCZZUejS1D6YEi8CBuSbtYgqVyHxJvpUjNKOn091weaWUThAdGVvVtDhVV2vc3
 O3sVHjTCuEcr4efV8V8h6vFzuBQXXWPRvAeXyzjv6Pfqls0FHhNXs8GatviEOhLKONsS
 zXk/ApeSeKExqcjOadR7uw1Fie0YFGEYoYV1bx0Ayk2Ax0pCrbcD7eTQMtMe7wXNgQ6n
 omwpnnmmLdc9TZUy5fbSNnk6VdCEkTE8w/8ABBZ7AFFyitZpDfXsvitnlstCrYJw8Y9/
 3hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754669449; x=1755274249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pF8E62wU9J+ASfzXPn8bcStUaHINPlKxsqQ7ZY+44hg=;
 b=nJBCbCjAGvGUWWoJjLQDf3iwpZpDgNt34Uu/vKECpzjIfqw0BSPjg6GNutWjrdqv+S
 LV3uMCX5+eC9PkVaFr2I2HD9Pau3bU9GFMNqgTmKhD0ZI86aKJsj2gN1kIMYvvrEA1V+
 4FlzARaL5m4VdE/8h48IomhNshKiR3MSFfUBiYYcPWA2CBa4FpqFpTPnMtMDE9XG05VW
 yBq3Yri8CbOJRjbCzG5SNxM8+1Xb5d5yG6OZtONAsi+rjpXfp+K+SfqhJ1W7SlXCm1pM
 2KxH5UOQNqz6Efs0TINza9naOgFggBZ3IRUUGb+hGzz5gv/Q9eAWhTqBtYQMckoSZ32m
 +i4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZC2gAVkEOaDevtmWt+UWqa0+NMSjnD7RIjvUFL3IkYoW/ZKl27vXTVPcLZOy/DzF6d8M=@dpdk.org
X-Gm-Message-State: AOJu0YxOUo2GkZswRkzDBPU9qUHLNow47ValIDLtq/na8jHFWsCr64i8
 GXN8N7+MlS6WfsqIHUEErIqVhl3OfaFExVZDVmx5/zPxIhKlTMBgi0G5dqX/MCiFh6U=
X-Gm-Gg: ASbGncswMeIl39fpLvCY8QCnTrRxei7T3lN8TQzs7tVylZlfcczcLhEiorw6DitsRUo
 jWHlIgsznBXLRUI1txLJBHL0Ki3nEhoCXJeiR9slu7K+LQ1JsLnCD4TC6PhCi/h9o18AlpEq4tV
 /fPPYxvYFP+oU2H6hPbG+VB2cuyZ4LXDNsgxR1KMkFqlviSjLMfeuH4uYpDvZgVHgFC9eKyf18M
 zn8LpqDmm/OYy5ZwJlAxlXEtyku7TWQpl8hyl4jlN6tp/hW0Oiu9asvKMdaAhLwSKpoVRcTEIVo
 qU9x8f84+F+YStQcQDcmK0QHi5g73HP31zbom67ymB/hiA+j+vVKu119/pGjG33TmN2psZDXqVP
 7D2YMHu1oGHXvoahISn+Al7hyZbEeklFLsWUsIIh6NCeKSshnWkMNbMs0QZnwSUv0FUcctVjcsY
 M=
X-Google-Smtp-Source: AGHT+IFXk91CKlWz9vhmRKOegJLw0BvB1MwumMlLjxVOEcUJUb/+KHXs/W2lSBLgCnO43bdDxv7wUw==
X-Received: by 2002:a05:600c:5248:b0:459:e35e:a90d with SMTP id
 5b1f17b1804b1-459f4f14148mr30328515e9.27.1754669449357; 
 Fri, 08 Aug 2025 09:10:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4532c4sm30600028f8f.36.2025.08.08.09.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:10:49 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:10:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Message-ID: <20250808091042.74218aa2@hermes.local>
In-Reply-To: <PH7PR12MB8596A4A5CCC22A6B1584AE14822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
 <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596A4A5CCC22A6B1584AE14822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
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

On Fri, 8 Aug 2025 03:23:37 +0000
"Varghese, Vipin" <Vipin.Varghese@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Khadem,
> 
> Thank you for sharing but few thoughts here
> 
> > -----Original Message-----
> > From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> > Sent: Monday, August 4, 2025 5:03 PM
> > To: stephen@networkplumber.org; thomas@monjalon.net; Yigit, Ferruh
> > <Ferruh.Yigit@amd.com>; andrew.rybchenko@oktetlabs.ru
> > Cc: dev@dpdk.org; stable@dpdk.org; Khadem Ullah
> > <14pwcse1224@uetpeshawar.edu.pk>
> > Subject: [PATCH v7] app/testpmd: monitor state of primary process when using
> > secondary
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > In secondary processes, accessing device after primary has exited will cause
> > crash.
> >
> > This patch adds a mechanism in testpmd to monitor the primary process from the
> > secondary process.
> > When primary process exits it forces secondary to exit avoiding issues from
> > cleanup logic.
> >
> > Fixes: a550baf24af9 ('app/testpmd: support multi-process')
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test-pmd/testpmd.c | 47
> > +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c index
> > bb88555328..b7affa6da9 100644
> > --- a/app/test-pmd/testpmd.c
> > +++ b/app/test-pmd/testpmd.c
> > @@ -101,13 +101,15 @@
> >  uint16_t verbose_level = 0; /**< Silent by default. */  int testpmd_logtype; /**< Log
> > type for testpmd logs */
> >
> > +/* Maximum delay for exiting after primary process. */ #define
> > +MONITOR_INTERVAL (500 * 1000)
> > +
> >  /* use main core for command line ? */
> >  uint8_t interactive = 0;
> >  uint8_t auto_start = 0;
> >  uint8_t tx_first;
> >  char cmdline_filename[PATH_MAX] = {0};
> >  bool echo_cmdline_file;
> > -
> >  /*
> >   * NUMA support configuration.
> >   * When set, the NUMA support attempts to dispatch the allocation of the @@ -
> > 4332,6 +4334,38 @@ signal_handler(int signum __rte_unused)
> >         prompt_exit();
> >  }
> >
> > +#ifndef RTE_EXEC_ENV_WINDOWS
> > +/* Alarm signal handler, used to check that primary process */ static
> > +void monitor_primary(void *arg __rte_unused) {
> > +       if (rte_eal_primary_proc_alive(NULL)) {
> > +               rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
> > +       } else {
> > +               /*
> > +                * If primary process exits, then all the device information
> > +                * is no longer valid. Calling any cleanup code is going to
> > +                * run into use after free.
> > +                */
> > +               fprintf(stderr, "\nPrimary process is no longer active, exiting...\n");
> > +               exit(EXIT_FAILURE);  
> 
> Indeed, the idea for monitoring and finding if primary is still alive.
> When we exit, should not we need graceful exit? If yes, we can not simply use `exit`, but need to use `eal_cleanup`.
> 
> Hence I request for rework with cleanup.
> 
> NACK: Vipin Varghese <Vipin.Varghese@amd.com>

Eal_cleanup will reference data that has already been freed by the primary.
That is the problem.
