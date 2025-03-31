Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A061C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 10:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C424C4065A;
	Mon, 31 Mar 2025 12:26:40 +0200 (CEST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 by mails.dpdk.org (Postfix) with ESMTP id 7843340650;
 Mon, 31 Mar 2025 12:26:39 +0200 (CEST)
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-e53c9035003so3731466276.2; 
 Mon, 31 Mar 2025 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743416799; x=1744021599; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oEguJA7sxiNzRu7SAaD4SSfHU1luGrPb5151zv8BajI=;
 b=Uu7vvSfqalqQ5melj8lf0LnzCXsM0kqJq7xpez0WfeE0Ofo26nWNAtCt8sbQEdfjj6
 svbxLbggKD6q+lCMUE6XRe7Xo4LKEKY0wSNE4jAbkP2Z5IGI8Y6E0hrXNENymZvfrZ4j
 1tz0js4C7WFet3fmflIRsh/5nT+99HM2QLoLYLGzXU8v6eEOpNto1wAlk47+dxHv8ccq
 bX++unEM759Dp3pAiGX+SDk4TX2mwzHrY+eIx+pCxCFTs2mvwp+fFVF9oDd/J+a4VTk9
 IGozU+5WLECv0A5FC3iAE6QjBJxdx+LulF6QwCdBShz5j12BznLa2Vq9eUKku4q24rjs
 Lc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743416799; x=1744021599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oEguJA7sxiNzRu7SAaD4SSfHU1luGrPb5151zv8BajI=;
 b=XMpE3S+DeGNIS7wCPYgG16Ekzh0jgmQ/lc+VOmYr8WXfKVc8JREB7HVmX0h6R9x+CQ
 BFHThikG77qXZEwcic2JH74IXhDVo8XS3RljR/h73nNjvFb9P8OiQm9iHCnte22fhM45
 5VkjS+E3qjscbjLBifnSKmkZ14TeVzHJHqSa1itnsr5yBqK2irQDGsSn6UQwZ9AgTJN1
 QIzh8c8G+DqJWeO+MwiGqC4XAh4aYJMvtvJOkds2WcH+4Gcvf9hsRs5U/QOWGyCKnp3D
 5CUx5wyzKJXKG4WyamnvNX8kuSYBOVZbIDOb/PZOg+v5L6568C9NZOnHl+vWIdez44o6
 cYzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAi9p/qkoqwxlVf/xCdSNGpfLslI+Z1/MqtsY51oyD32I3NJN8WfC5c/oqNJm1ZmJmJpZsGmffAMoT@dpdk.org,
 AJvYcCXEzaZ9qHE8n6NPlaBzMksyE2VtpvrVBD08N2aEd62kAPa6bG1uXCKpRfTxodUbmb9A8Do=@dpdk.org
X-Gm-Message-State: AOJu0YxEfCeEeutRq4LbyD0SaJWiYTzJF4M26a5fbzpiUYJaFrWScE49
 5HU4ORQcYOLYSpfTQRR/JtAcQzfz4LQgMP0YZ3s/a9HBV9HXJTjZYL5cCSzCd0GqPCyKkrXNf+r
 Fqzuwou+tru8svJWcn3DJ879koQ0=
X-Gm-Gg: ASbGncvMRAoIy6l5LPIKvP2SU7zn+NTmCNSCzp8PWgxQk5TV/3MHfsmI4EWMT+mQ0pI
 Pu+PPuJByiB2ryec1vdHZe68eY03O6xZv4GJsRsARHCgzT9zrwwAeuHE+81RxwR62bvWPbxwE0f
 lfVfBQfamRRUKzyEpg1OtIMrnnqnKTf+6lmXWiUoVOJzzeNR7EGTLMpY3Lgt0=
X-Google-Smtp-Source: AGHT+IGFaKBQo6jjONDh5BJLNzTkZp3/pmM1IvfGnz57nLcp30fm8p4B0nNhM2+tYZnRGEy4JqGwyuierwIdZ4EmbEk=
X-Received: by 2002:a05:6902:2102:b0:e60:a3f1:b13b with SMTP id
 3f1490d57ef6-e6b839a0918mr10857486276.18.1743416798747; Mon, 31 Mar 2025
 03:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250306133713.393057-1-getelson@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
 <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
 <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
 <2e308be8-8ef3-963-cbb2-5cf68a3d3b3d@nvidia.com>
 <20250328122516.733217af@hermes.local>
 <Z-pcP_sbk5T-e7EE@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-pcP_sbk5T-e7EE@bricha3-mobl1.ger.corp.intel.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 31 Mar 2025 10:26:27 +0000
X-Gm-Features: AQ5f1JoIgejrcEUG8ZS-5q9-2YBgMdrSCUwObPRdPJgF_CJg5m8MsjGlw3wZVLU
Message-ID: <CAMw=ZnRoc8n-FMi6F0vLtGnZGwcqAgXc3h=35wqNkKK1qc3BQw@mail.gmail.com>
Subject: Re: DPDK for rust
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, "Etelson,
 Gregory" <getelson@nvidia.com>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 techboard@dpdk.org, thomas@monjalon.net, mkashani@nvidia.com
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

On Mon, 31 Mar 2025 at 10:20, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Mar 28, 2025 at 12:25:16PM -0700, Stephen Hemminger wrote:
> > On Fri, 28 Mar 2025 21:09:21 +0300 (IDT)
> > "Etelson, Gregory" <getelson@nvidia.com> wrote:
> >
> > > >> Hello Morten,
> > > >>
> > > >> Thank you for raising these questions !
> > > >>
> > > >>>
> > > >>> Do we want the DPDK project itself to support rust?
> > > >>> Or should parts of this be a DPDK hosted project, like grout?
> > > >>
> > > >> Rust packages management is different.
> > > >> Also DPDK Rust code will eventually provide a different API.
> > > >> At this stage, DPDK hosted project looks like a good idea.
> > > >>
> > > >
> > > > For ease of use, that would mean hosting a cargo registry, no?
> > > >
> > >
> > > That's correct - cargo registry is the native way.
> > > Also we may consider splitting the code between several crates.
> > > That approach can provide more flexible way to arrange files.
> >
> > Talk to Luca. The current rust cargo registry model is causing
> > lots of grief for distro's such as Debian, Redhat, Ubuntu and SUSE.
> >
> > Packaging is always a pain
>
> Yes, but cargo is just the way the rust ecosystem works right now. If we
> want to have DPDK available for rust developers it needs to be accessible
> via cargo.

Making DPDK available on it is not an issue - the problems start
popping up if it is _used by_ DPDK to pull in dozens of dependencies,
as it becomes way, way too hard to manage. If you only use the
compiler and the standard library then it's doable
