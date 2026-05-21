Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ED7CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 16:10:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66C8F402A2;
	Thu, 21 May 2026 18:10:40 +0200 (CEST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2CA7D400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 18:10:39 +0200 (CEST)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-39380e79936so67432041fa.2
 for <dev@dpdk.org>; Thu, 21 May 2026 09:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779379838; cv=none;
 d=google.com; s=arc-20240605;
 b=eE5/Uu8YVP4h5/SHhDop9KvT2N0W0XWy+vy0u2Hv9iPAS2SqkdqqYI2WT4fuLmN7Xi
 7SuWC5PRzJPJbKutFDPbM89KSb9LJLr3LKqvjYZYVQ1mobzTGIa7LBQ8Kq/+qamSDzIq
 Swbq6bB2/z4wVeOUYrLL5/RwdowapqNCUQdcNlYi6mDzGvBQDvcrsJgMcp5PaA9gazET
 Nxwtjgl/fn0hx4b/60aC55dPQeKSeW+Pgp4x+Vm5eMz9UESXylnMnCaOob3/Bx+8RZgH
 WGSZ3G2SHTCnypRiyQSntuCQyTdV21RaNYsiSV2/qwSJ/+4aXR9OKWOvWuaUAJuFBYlL
 7Ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M1JkfUHvyDMjmPU4KWYMqikqiKDtKaCwTmP9beDxvWI=;
 fh=VvfBHRpTVt89uO9rsd/36jcKvgFnz7OnodiBN0jlx60=;
 b=WgywcdQLf3NleEm3kUJImTlBNoy4KG3qoF8uYmMJK7GIErEAiJ0r+s5DqLiUTlIly+
 rrgbJdvfDhFLXX5hod4TAV+s79fhcWyuEa3pBQttG1oNrPGKvpyWB3dPqG8GZnVraca/
 ukG3AWZ7mmAAOKib+2daq0eBto3AC1THNciN6drAvxco8fHcLCy+4PkT1Eyl8Zke4rUw
 ob9rzZkfxuQ7Ks4gTIRGybUPuQQUDzAL8X6U4I+xc9A4lPl6UG0QNSop0PiqOJ4t9z0d
 Eq9bLprlZwlidNeeSb22h+hTbuN/JPRUBmSiEYwsH+U24/nkHkpcRVyUS2dKQFcclRcU
 A3ug==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779379838; x=1779984638; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1JkfUHvyDMjmPU4KWYMqikqiKDtKaCwTmP9beDxvWI=;
 b=KdiI4uE+GzPz/l8IXuU4QJUmlgLTCf/LAo4ODi1uEdbCC1JNRKGqMIGMrq8+SDRWK0
 6mA6hpZHyfACP1z9la1WRZdkH4IsaEYvn1sH1q3lU8yxz7ayIE2dHqtAquc3ydUUdIi9
 gVYYuY8WkafiUdZlV1RKN4CtFMW8vJePb2bi1ZyhsM0tIZY6lRu699owhs6A7Oc+F9OP
 5HahnpXZ5xyct5k4yzQQ6eV5zXs/oazxQg3GF/BahUjr92wq+LM2sSCn1cQM+J4Q8ezD
 1tUJGCxZeOzGcAJrJ0vWhytJjv/p3PeDz803cZQoA3baLrUV9hZEa+0pop3Bkf0YP2di
 /AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779379838; x=1779984638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1JkfUHvyDMjmPU4KWYMqikqiKDtKaCwTmP9beDxvWI=;
 b=ZMeD3yTBfGCQMDaWezMMCMov4Chz91GDf1i3CuMWPPUesHbJ9Es1NCrP5qHv2LBt+1
 70cOhMYVJ9hqb0Q+jNj1sjntiIEs3en44pJ4qRCN+qagMWRd4dp5Rre9OEFYSj7Phj2w
 9cuSMVOuxgWWLzSNtFXLZ7iC6sl3fALKQIB1B+y4ZOuvqJv649thq1q00iobWlcjENYu
 N5XxD6XDylXz0xOrOJpMpgcG86Dv1CUuTn3cqqSPFhRKCEUvi9xCVdNe6HcJtfShPjA1
 XucjIKHjyokPD9mmtSNmEgTPgINCMpkA2Zwuc0HKzivzXD1mLkeU/rwryGF2JZNAQky7
 JM1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zC3NdkXv14J0r6MwseLL4RVUzdatTCwV8ucxtPfxRy12noJzPP974oHrQee02zt81X3s=@dpdk.org
X-Gm-Message-State: AOJu0YzB5B552dx+fFK7MSvivHeta4/D7z8QVyYTr7Xmnl9qQqKXfGS+
 CkPcbQCoo9qr7rtJqaj9CnXUMPqjCSsNXacVUxyusJKNgU8yfUVJfWaDqgwf4dYDJAwisn1+wOJ
 F+U5REVhv4f732XQva2q7o2JBqwDHouQtaiW7VGvb
X-Gm-Gg: Acq92OEXuLR0H4TMJ2OeIIDnh9j6ShiDYSFX+ZtJbt7hTBL7yZBWRy7O5+ryuGSgMAj
 JK4kJXa+t3iewdX+Z9VSZ3cDGaGAdrmn+D+34k5Wznxtx1gkwBrWgLNpwwy2LPTRtnHwHSCztIo
 k1cZ+zSBXKJr50B74tJRUnjb7B/ddT5udgEGKohwnTunwbmcd8naLNiJLWyeIwGCdGAACfPDLHV
 WehRdQiSCeqW+7A78V4Wix7MdMnRqnbK/4KaxjlBLn1/xMgGXsxEdNFzgKtYg1Yy1Uk8ZH8dH9y
 FkF7JaDKE6jjSxREuA==
X-Received: by 2002:a05:651c:1468:b0:394:e5e:f12b with SMTP id
 38308e7fff4ca-395ca61e8d0mr14387661fa.17.1779379838023; Thu, 21 May 2026
 09:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
 <20260515231936.3296603-1-blasko@google.com>
 <20260517161545.2b33289a@phoenix.local>
 <CANULgnJv8LyoLZhGfn7gPxo-=2Z3ZSD8jCv9jAf9bCu4RZCaiQ@mail.gmail.com>
In-Reply-To: <CANULgnJv8LyoLZhGfn7gPxo-=2Z3ZSD8jCv9jAf9bCu4RZCaiQ@mail.gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 21 May 2026 09:10:25 -0700
X-Gm-Features: AVHnY4KtmLlHk_phCcbvzbNKSpNR3K7khJsKzEbheBzElMeNfDvS5UjkDvZLFOY
Message-ID: <CALuQH+VHHMLV=T=GfzuqUznjsD7g6pUWuBCV++ZEXELyQNC2Dg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] net/gve: add hardware timestamping support
To: Mark Blasko <blasko@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
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

On Mon, May 18, 2026 at 11:44=E2=80=AFAM Mark Blasko <blasko@google.com> wr=
ote:
>
> On Sun, May 17, 2026 at 4:15=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > Warning: (unchanged from v1) gve_read_clock and the periodic
> > gve_read_nic_clock alarm callback both issue
> > GVE_ADMINQ_REPORT_NIC_TIMESTAMP into the single shared DMA buffer
> > priv->nic_ts_report, then read it after gve_adminq_execute_cmd
> > has released adminq_lock. If gve_read_clock is preempted between
> > gve_adminq_report_nic_timestamp returning and the be64_to_cpu
> > read, the alarm callback can memset() and reissue its own
> > command, so the user thread will read either zero or another
> > command's response. The simplest fix is for gve_read_clock to
> > return the cached priv->last_read_nic_timestamp instead of
> > issuing a fresh adminq command - the 250ms periodic sync keeps
> > it fresh enough for .read_clock semantics. Once the dev_op
> > registration is restored this race becomes reachable.
>
> I want to make sure I fully understand the API contract here. Is the
> fact that .read_clock does not require a fresh device read documented
> in the DPDK specification, or is this based on typical application
> use cases? If the latter, what are those typical use cases?

Looking at the documentation for the user-exposed rte_eth_read_clock()
API, it seems that this API is intended to be quite accurate on a
read, or at least more accurate than 250ms of granularity would allow.
This is the example given in the documentation:

> * E.g, a simple heuristic to derivate the frequency would be:
> * uint64_t start, end;
> * rte_eth_read_clock(port, start);
> * rte_delay_ms(100);
> * rte_eth_read_clock(port, end);
> * double freq =3D (end - start) * 10;
> *
> * Compute a common reference with:
> * uint64_t base_time_sec =3D current_time();
> * uint64_t base_clock;
> * rte_eth_read_clock(port, base_clock);
> *
> * Then, convert the raw mbuf timestamp with:
> * base_time_sec + (double)(*timestamp_dynfield(mbuf) - base_clock) / freq=
;

read_clock() having 250ms granularity would completely nullify this
use case, as it is entirely possible for both clock reads to hold the
same value. And even if they _didn't_ hold the same value, they would
end up being 250ms-worth of NIC cycles apart, instead of a more
accurate representation of the delta over that period of time -- not
very useful.

--=20

Joshua Washington
