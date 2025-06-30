Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36318C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 18:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A698402B1;
	Mon, 30 Jun 2025 20:44:48 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id E6C664025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 20:44:47 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6fafd3cc8f9so40796566d6.3
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751309087;
 x=1751913887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gO35q+cUAtzA1GxB6M/GflckkpWeN3AKKNE2CQ/sORk=;
 b=jcdM246xxixoitsIs0baKln2SsP06xRRaughm/pnfG1sn2RiZBwikPXUHN4RrwLQUX
 CRTJZM5ndym3JI26011tQFJnxlR+lZcodaHfQ6pZA5cDD8HVQIRb+58CuCij9zwffamg
 vTwtXzDXzx5YI/tZdvAfQ8Xtkz5V49wkjGwHEgpFgmoJtu0lscHK2gGwE4nYH8CRQkDZ
 v9iiyR0F4DWS5VwSoIFL5oczPE44Jbh5xU7G3+Zp6ST/5+Z6vMOFys81Y6lNNv/1cj7Q
 /T/bC6qp+Leet2gFMMj7AUOZCZEvptTU41nkzJw3JkQe+vUV6I4o0LqiiDaI6o0Qx1Yz
 j+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751309087; x=1751913887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gO35q+cUAtzA1GxB6M/GflckkpWeN3AKKNE2CQ/sORk=;
 b=Rtg5QGQ/lwOq/37rmpy3VtGlJHPpVJBVEE4SDOVZx3KpNQNSAQhlrAT8ddGOGnId/9
 kZLvdV21tZ6J4T/c28Lk7vgKFqGs2wEt1EkbuSMqdU2KPa6BPui6UFzc5xcBWgaM32hZ
 Ii3dhj2FxIPmIQjtcpY8vvixgao4eYUL8LfnfrpFhjkegJDWD+02zT2HZyv3H32UgC5j
 ErDErVP2ifYFoEBciuAOC194G0uTPrphvNfvp38btdo0ueZOn3JmWkNYOoBsD5axrIev
 89llnsyRHlnQyTtTPpX1OmNTCuB/K1dDMLIYbcfA2qaJrQH+5g4sYmUh7pxvuhsC0XrD
 2gRA==
X-Gm-Message-State: AOJu0YxWzoromwR6MQFzQixqaeAJgQDxMs/mIvVtsG8E/Rnn2yjtHUpD
 tLk7A4ljqjRUrEip6taE5uIa1lZ1onLeWtvDt1NhOfGQ9ZJS6OZKqwfXcUMUg4CuG9pr9cFQJUs
 RuGX8
X-Gm-Gg: ASbGnctDjphAmz9B9XGVy1X/BDNyuHjZ43hDTSwtycYoksH0Db+MZKAbm6rn5toZ4d2
 Q90/3BoTDp3qD03GFdlMW6HarA1WGMkQWHeIq7ajg7UThsSY5k2QW7RghzJ0P/vPmYunU8EwJH/
 EqtKKlEBzIhmy2XH5uvlVfs9JJf16rDmAjBiTye7Y+JSLv2elo80ozK05Eg7xxEzeaNChGUeh0L
 SZHwsPenhrzAykZgMwM8e4ethODfliiB5/j2p2pfjmumWqdNrP5O2lnLgAAuZVOhKqlod4OPm5v
 4rtsAt9ciifjgu1bsrxAZuBn1e6kBwR1QDnGgh/ClVs62kqZIS70eOnJRG/4Hxsk44qoXD9phdz
 KjaAK8pfu55TXPE0/KR92td1sPJNJqPFgRy7tDhk=
X-Google-Smtp-Source: AGHT+IHbbsVN1XkK2baZBWzehrGh1BJfWiNEN9D0hrlwPV/SttHu5H6B2fKo1xAoNY4tlFDcZLno7Q==
X-Received: by 2002:a05:6214:300c:b0:6fd:ace:4cfb with SMTP id
 6a1803df08f44-7000214f5fcmr299193916d6.27.1751309087256; 
 Mon, 30 Jun 2025 11:44:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd771dd8afsm71540656d6.54.2025.06.30.11.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 11:44:47 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:44:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shivaji Kant <shivajikant@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>
Subject: Re: [PATCH v2] net/af_xdp: add rx/tx queue support for af_xdp
Message-ID: <20250630114444.54a9838a@hermes.local>
In-Reply-To: <20250630085052.585867-1-shivajikant@google.com>
References: <20250618174103.1345466-1-shivajikant@google.com>
 <20250630085052.585867-1-shivajikant@google.com>
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

On Mon, 30 Jun 2025 08:50:52 +0000
Shivaji Kant <shivajikant@google.com> wrote:

> Drivers like GVE work with rx/tx queue configuration
> rather than combined queue. Enable AF_XDP vdev to use
> rx/tx queue configuration instead of combined queue
> configuration if available.
> 
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> 
> ---
> Changes in v2:
> - Rephrased the first sentence of the commit message for clarity.
> - Corrected spelling error "dirvers" to "drivers" in code comment.
> ---
>  .mailmap                            |  1 +
>  drivers/net/af_xdp/rte_eth_af_xdp.c | 30 ++++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)

Applied to next-net
