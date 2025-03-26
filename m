Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D1DC3600E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 20:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384634021F;
	Wed, 26 Mar 2025 21:25:54 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 0691F40156
 for <dev@dpdk.org>; Wed, 26 Mar 2025 21:25:52 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso326526a91.1
 for <dev@dpdk.org>; Wed, 26 Mar 2025 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743020752;
 x=1743625552; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwdwbatOBd6du6JgRaIH5lRUo6tm9bEfsSKesNL5w1E=;
 b=V2Ob/QkfTcYk/vnd66izmjoKu0H2OKXSg9J7qKfETCbp1ZCPBaz80CUbV1THIqZWD7
 IO3i6yLrSsAPIUFL+jG0XGo25EgczQA5YcqgyId8ME/XATDGxALOeYF6xL69WLnECuLx
 QQ9wPWg0eZ52EykNCaBPKV11ZNdqoMjh4JQ0MIQYKJ10vbN/w5dzWloKC0pwj+IkvZpX
 lq8nvQgKE8a+27gHO5r2BEHMYP0/0QnFgQtLNk/zhsO41H71RgYIj43jFcDXEigb3FbM
 CZRLasqnWjCp/qckeEozvNGZc5S+gjjBpu+zD8PE2VsW23Ms7faKmQenzDl9Nt4NL1Z6
 8nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743020752; x=1743625552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwdwbatOBd6du6JgRaIH5lRUo6tm9bEfsSKesNL5w1E=;
 b=mo5kw4d5MHwQf7iQ/0FwWgGB9agPpi80zdPrgG51EuJMtHE+nqrYKitrTZbNzgTchP
 C29GV8vO8NXy10VxdWY0ODvdDNBvM05hd4hiZ8DQa367cRLjvv93Qi6J923hGRs93hBx
 byVFzbuYdawz1k6f+V/GSyQWziwpmkD54qU8oAgSYAjpdujvnG4zTs96xrmpR0DiaxGn
 HvvhHkQicXZDNYm9EdmpSEZibial+5t1HXwGKvjrYOvv1fZt6lhH6ggse3CF+BAceqZp
 E5wxMQ2I33tvieCi2yYOUuGEtLqKCbzaPjAdmeGdQCy0cWaqfN5K7+f1CUIszwpj1si0
 C1xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJzjhewyobxwxl8KBtiuDchtOqCNVPDWRkuHaOP2IPY/fu4ua/XwGIWqXc3llTAkmB/+Y=@dpdk.org
X-Gm-Message-State: AOJu0Yxtp8+wlHvCBHzGSM+a3ElpiyxsaE/hLFlt8yS5w0aFkoX325qA
 6qQPJdTAyCE/8dpSdcUj8hy4gJpz8tqPPhv73jElU76LQbppeYWKdpFmOxsReZo=
X-Gm-Gg: ASbGncu7hcylyGWPP/CzZqCPyh3LbquJAdiT/OrPPx/xNtzjPWmt9HNsRKwRZ38iPi0
 /cAzPq4jyE+W4ZpJY111TzxjadXLdGQ0bWJm5847MyJjLZApbFaP6RbR+ompULB91YSGjvgS9Cp
 CN/NOx/YN1GpPxERn4ouqcNl0/VGZLENwRl7+psrEiVuxyDCUPkbAHaswfXjTwnqx3aG11I2rIA
 k29yDbNgOsoK5KRXMhbfg3y0sYEKWtf2edGOQKyPZE2QRsFu01nEjc/Fz5fOz72VoFQXl648p9k
 tLFDyp64Dsivwbqb3sserYbRDO2qOSyVr1tvxz2K5xt0R76FTdgiBudwWtVfm/SSYOARxr5UqKA
 lG85NN9fpgFRVsZ1QPtqt
X-Google-Smtp-Source: AGHT+IHElR3J7oVweWNV65VFTXG3ajqPLMSPlxp3+LBgBvuYctpYafHCjIUT5Rpqqk1G3vQkEuJMRg==
X-Received: by 2002:a17:90b:2fc6:b0:2fa:17dd:6afa with SMTP id
 98e67ed59e1d1-303a7f6d40amr1789286a91.17.1743020751659; 
 Wed, 26 Mar 2025 13:25:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dff0534sm682376a91.17.2025.03.26.13.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 13:25:51 -0700 (PDT)
Date: Wed, 26 Mar 2025 13:25:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] Re: [RFC 2/2] eventdev: add default software vector
 adapter
Message-ID: <20250326132548.18a7e8ad@hermes.local>
In-Reply-To: <CO6PR18MB40846EBB54A664C6202851C7DEA62@CO6PR18MB4084.namprd18.prod.outlook.com>
References: <20250326131441.5965-1-pbhagavatula@marvell.com>
 <20250326131441.5965-3-pbhagavatula@marvell.com>
 <20250326071857.7ef4a050@hermes.local>
 <CO6PR18MB40846EBB54A664C6202851C7DEA62@CO6PR18MB4084.namprd18.prod.outlook.com>
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

On Wed, 26 Mar 2025 17:25:32 +0000
Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com> wrote:

> > On Wed, 26 Mar 2025 18:44:36 +0530
> > <pbhagavatula@marvell.com> wrote:
> >   
> > > +struct sw_vector_adapter_service_data {
> > > +	uint32_t service_id;
> > > +	RTE_ATOMIC(rte_mcslock_t *) lock;
> > > +	RTE_TAILQ_HEAD(, sw_vector_adapter_data) adapter_list;
> > > +};  
> > 
> > Why the indirect pointer to the lock? rather than embedding it in
> > the structure?  
> 
> IIUC, the lock itself is declared and used as a pointer right?
> I looked at examples from test_mcslock.c, and this seemed correct.
> 

Forgot, these locks used linked list of waiters, and root is a pointer.
