Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9961BCD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 18:44:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B882F4065C;
	Mon, 18 May 2026 20:44:10 +0200 (CEST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 3359C40041
 for <dev@dpdk.org>; Mon, 18 May 2026 20:44:10 +0200 (CEST)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-bd8f9889a8cso69701766b.1
 for <dev@dpdk.org>; Mon, 18 May 2026 11:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779129850; cv=none;
 d=google.com; s=arc-20240605;
 b=csm0qMSWFWMDBIlQxEInhXXcku62HnMbYb7AzL9Yiw+x1sZjxCLTuiZt+cnKqujEE3
 tfV4W8rfIA/oQqs5jjGbl1wJK/c+dSQAe3e59RvjF6kytvkcFi4h6dOO6Jp4ZskRZW8C
 MEc4tJ8QhHkcbU/w260Gxfd4MCJQ8wBNEDNuL0SKjRae/nS1ixjjboZGoKl4QElouy9x
 mjJRuRY21+3xZN72z+HK2mUNwPYzEGmPoLkPTlzK0zehU0d7v9q0fnLnOQPSjusRlYSk
 zE5r+aUvQFMLPhoHij9RgnS1ixJAGpGWhYJJKz+gCvN8eYFefk+80qjdgkEGNj+16vZs
 NTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s0oy4844WBtSru5IDtCRA1tqRjqrlRXQpdkRIO8Xukk=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=bE+VQfg96eaP4xYYgoF/ReYDUdJV5dQRwW2H6GApF/CUDJtC7vMz1VdTARjhaY0pTU
 hcX5/jSERtOsfr5rQffJwvXjSx1GC7Lf2U+/+ZpO+w3Rb0Mg8so1EAOOEoKV8RG0BGGc
 70kprJlcZRIQBe0UL1VSDubV1RIaH/YaB5a/1slrMQ8EnbA8DWQX+EFnU6hHfdJMPmzT
 e06Xi/feGIEHA6KyDEUl1n/QJCV8N+bdCBgF53wv5QkQrBwxsLadgsHMPPealgGiJHoP
 lfypzwRELFtF8w5iFAamMnYO+YiUJNvhGMOS6S6d1VO0KKH4l9CnviUpLBd9/DLI01wz
 lPIw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779129850; x=1779734650; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0oy4844WBtSru5IDtCRA1tqRjqrlRXQpdkRIO8Xukk=;
 b=MxNg4l+clRu7EPO5MmNC9AB0jIwm45kVSAfQBPxh87eGrq+/GZPugMf1Xnpv4mF/4i
 n9YQMsCEizuBIy1kBEtpEgRnV2XOHGiNN2G4WQxXoPxtq8AZnICkFZrKx0ywoZwjYRD2
 /2bGCuczw0kactksQ5dWHFYXiTnvz37wP5lWSvSn71b0kxPVhn+rQj64juvTnNVKDBhw
 rHP1xdlzukUAYqzuxG2QTddwmwYq19lQhsfy15dXUdywmn1xJobxnl0FM2/HGai6M2xy
 N7aEops8ZJFY+R503XAVXsVvBiSjukJQmnFvkFST5E2fWXIw5phDks7MCDH8qBfyW9Bg
 Goxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779129850; x=1779734650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s0oy4844WBtSru5IDtCRA1tqRjqrlRXQpdkRIO8Xukk=;
 b=cN4BIm3bxbrMJ+pkYjI2L5LraaTKqmCOjpJyn9C6pybZeHTeB0nskVyKn3DjUbSfKs
 pUTK4F3pb3BPC68U5ClhY2j9L6hM+puz6c1KjFN6gBvo4Kj0rGDCcay5aBWleunoUNRp
 leD3HyJA0sJDYN/Vf5mohmYfynsiAJqrO6gmO9L3m9L5fBblvI+r5pIahUZByUmow7jx
 WH6yn/RpLaTUTZW9cjnyni37GKv6wyG6dv/W324T0vjuQRIYJmnZWlDa+tqrtmoam2oS
 OqKrcW+XPXIt4BdtL4az4dzVGUs1Jq6/TFEe8kQ+YIBga1Yfn0Y+EwANamX5ehQv5Wob
 sCSw==
X-Gm-Message-State: AOJu0YzhJZzcRvoxzDQneViaBWdHyv2elwrEyPmYJGGVfYCGY0/mH1cH
 gquYgIUn8MzIqkJwb880t5Z47emHx9O955aS1mPNScHcfRXjqpLz5HrRleX36aKy4uC9l+HOmq+
 N74joV1zD+DTCtFnYzwCtzDXOuhud/DupOg5Mlz1B4lpcedvxjpolsGfiywg=
X-Gm-Gg: Acq92OF87KdZMm4xv/G97FIhSRuIl/wJk0lj7wMeQUPusA2nbK5dgWJR+agY2QJVlti
 HIeXliWYXzQhWR+8feNRiIBQSFDGAx2RWrVfhMDEpOg1R8n3fFJgDTE/byHaheWtUWUMzX5xmjv
 EyDzpbj+OIH1P4dOBJowGodDsTF+JHwo29H8aWH114b1WhxYSecH5540Pq3zVQ1PzONSjsyrL74
 f35XEBeZotNvq2ufV49VDjP3xuNvEMzJL/LfwNOOMAsGJxtjoWkuUQk/F6keMENequuPQFF1y7F
 E6Afy/QsvVrcABK8c3f8thPJaCFGQm78+NE4GKZ6Ii5uSxglsIob6edptw47NfDE8m88GKsZJYz
 IwqyVDcXU8fAknhuQf9qAIAk5KQpbEjI=
X-Received: by 2002:a17:907:d06:b0:bd3:c295:d76c with SMTP id
 a640c23a62f3a-bd5177afe53mr986802866b.1.1779129849024; Mon, 18 May 2026
 11:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
 <20260515231936.3296603-1-blasko@google.com>
 <20260517161545.2b33289a@phoenix.local>
In-Reply-To: <20260517161545.2b33289a@phoenix.local>
From: Mark Blasko <blasko@google.com>
Date: Mon, 18 May 2026 11:43:57 -0700
X-Gm-Features: AVHnY4J8mQG0lTvo_YAeZtWJgtXNunyuQdGtLxN3hh9GJ5dOFZJhficYzWBzSlo
Message-ID: <CANULgnJv8LyoLZhGfn7gPxo-=2Z3ZSD8jCv9jAf9bCu4RZCaiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] net/gve: add hardware timestamping support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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

On Sun, May 17, 2026 at 4:15=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Warning: (unchanged from v1) gve_read_clock and the periodic
> gve_read_nic_clock alarm callback both issue
> GVE_ADMINQ_REPORT_NIC_TIMESTAMP into the single shared DMA buffer
> priv->nic_ts_report, then read it after gve_adminq_execute_cmd
> has released adminq_lock. If gve_read_clock is preempted between
> gve_adminq_report_nic_timestamp returning and the be64_to_cpu
> read, the alarm callback can memset() and reissue its own
> command, so the user thread will read either zero or another
> command's response. The simplest fix is for gve_read_clock to
> return the cached priv->last_read_nic_timestamp instead of
> issuing a fresh adminq command - the 250ms periodic sync keeps
> it fresh enough for .read_clock semantics. Once the dev_op
> registration is restored this race becomes reachable.

I want to make sure I fully understand the API contract here. Is the
fact that .read_clock does not require a fresh device read documented
in the DPDK specification, or is this based on typical application
use cases? If the latter, what are those typical use cases?
