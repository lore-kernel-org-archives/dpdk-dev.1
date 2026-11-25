Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97C606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eJHiePVU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76F6140284;
	Wed, 25 Nov 2026 19:54:11 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 232DB40274
 for <dev@dpdk.org>; Wed, 25 Nov 2026 19:54:10 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2f0414c1062so37542275ad.2
 for <dev@dpdk.org>; Wed, 25 Nov 2026 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795632848;
 x=1796237648; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RD2bPGeB5+Ak6TVHK4yCpB18jhngWBBNvcG88miyPtw=;
 b=eJHiePVU/nTQp/Zc8PTxTv9cvy4am/ZTk7V3ZKoppjymd/BHOunoj93ZlEkIH6/WMx
 AGkPz6CCmOvjRvaG3eKjS4giL3OkJ1lTpRCmQgolis24kzJe8a02sMJ7SqG0uw2VfXeh
 9djQ5n/vBWL7LWtyvmy1Pg3GuS1R6Y04X5jqxYQk9EBC3gWZ4CxRSzQ9lu+fAHQ7uGeC
 iD5upQocT9hhq8OZCxhabsqS5FAC7Wm8bosrD+SCoVPD/rMeLA4dx+0lqBia0WT5Ul51
 ET7LI/b7l7tgc4As1eiC7yI/T8vk7sKv5hrPGynCaLgBXX7gZAkjhu7iG/yfRXSWm+78
 si8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795632848; x=1796237648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RD2bPGeB5+Ak6TVHK4yCpB18jhngWBBNvcG88miyPtw=;
 b=d0HB6lyNbthwtK0Nwj3LOhlOTVR2POx8XQpP7+cWvK6yPtpXD9MirgWtwj/I19qIFY
 fdiIMDsxgTiXw+04123LKp/b5pAj7lS953S9wDurmLBmsymj+v6B5dU0lLOEm+bhvSv9
 OeJT+yaD7TYIeGBhm79tPM0ab83djtGySUQn2YIoUHTsU1mBYh671XblEUWv93NmBYvo
 UQgEsLPW+cMHBvpaCslewiKG+PzIWzo5f6DU2qO67fzp91W/xjSkjTA0+rsEH9vkGglE
 iCjFWDkPj3Uh14wT9NIykKm9CpmVB5r+xohyG9wLgu+QqiEBoZF0MzX0m3//onzvAnTO
 6XIw==
X-Gm-Message-State: APuU4Z+iurAV/RCyMKRSgNbLNkw4ds4oKJF9PzKKSsl0ipgFivUpCKTs
 jQVZb31HlJJlWh9/S75J5L68F9NfHH0lSFdEZ35kkrxKYAyz/8ePgsGVYvY3fkjgwabBBSDOgPV
 ID+jtEjA=
X-Gm-Gg: AZFdTZdk7ucwflUV/C0drb/+mJ9tqDp0AVi69xy+HeJhiIw7/nA4eTwrCtS5hMBycaH
 eqKOn/oVSfbGDJkZRvgvHxTGscjODH6xAcwwtIQg2krPeowRHNPQxKg3ciH5fZ7yoYyJDszSy4u
 xAiBauGVzMVU7oPkSx7eOTz1HJ+MIwEWYqt8CHctXVaC+8N7p8j+cVNPow9LLE2AWd93Lzd3gBE
 Cszd1IU2PnJlGicleMNlhPuD7tKvBFcnVtBTKsxvfYaJnHsj29Al4OjZdnyOXqdl35whIy0t4Bq
 Elpy4+87Nzg1uPPGUZgnDMizXFIezn46qTk9xnyKxQ4VVuynkjQd2BTZVh6r2/WrLS6N8NZn1Et
 90ujOdjBSf7tABmBdaargbt+jF1co+VH2kCy9e3HsHEw+1UTyL6u3faY8oR29WZGPhrPpuaNGZv
 9bbZwiawkQgjaVuU1rg1kArx+ZDpkEq8TpMOoCc00ehkXWiavrOoFLGoKg+aecfLntKhn3P+jaF
 V69iX34JLt3bLKYuqbKXI4ZMggLA3SlSgtDveE4wRcMmaAhPbpE3AwQbFiSsmtc6n1mjuia+eM6
 ETRYBAGM2zhwo0Pnh0f2JaITzYFwgFy3oHalrfShZObtXhswqa0JhadQFW8ouEUWQged/s8VAIX
 r7wAbANSiI6rLS0sy
X-Received: by 2002:a17:902:e74c:b0:2ea:778e:8652 with SMTP id
 d9443c01a7336-2f03f118b18mr180277075ad.14.1795632848222; 
 Wed, 25 Nov 2026 10:54:08 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03ee84425sm93058985ad.6.2026.11.25.10.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:54:08 -0800 (PST)
Date: Wed, 25 Nov 2026 10:54:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: document that fork is not supported after EAL init
Message-ID: <20261125105405.07d86c01@phoenix.local>
In-Reply-To: <tRHmK-wGRvSfdfy-XxmTYA@monjalon.net>
References: <20261123182202.340811-1-stephen@networkplumber.org>
 <tRHmK-wGRvSfdfy-XxmTYA@monjalon.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 12:18:59 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 23/11/2026 19:21, Stephen Hemminger:
> > +    A child created by ``fork()`` after ``rte_eal_init()`` must not use the DPDK.
> > +    Calling ``exec()`` in the child, or making no DPDK calls at all, is safe.  
> 
> It would be safe if we didn't have atexit(unlink_sockets)
> in lib/telemetry/telemetry.c
> 
> 

No fork breaks many places like hugepages etc.
