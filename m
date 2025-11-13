Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA89CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 18:59:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79BBE40655;
	Thu, 13 Nov 2025 19:59:18 +0100 (CET)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 414DF40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 19:59:17 +0100 (CET)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-786943affbaso10360907b3.0
 for <dev@dpdk.org>; Thu, 13 Nov 2025 10:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763060356; x=1763665156; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhU2bhHlpEBaups4VjvO39CPF3zKUcsU5JmKc9lBHpQ=;
 b=CXfnC8HLMpfgWAgmTDnahBEJXEPz84oRrqAG1IV6DXgTELzz08MuUweiNm3fSw3652
 ap2eJTJdGOqBSDX99f191oIXcRBukcl+tI0Un4f6nuis0i0SjhYoUl5nJyfTJNFktmZg
 Zrgekjht+U17AYRvvwG/g1dSSc0OXTBBjQ7vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763060356; x=1763665156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KhU2bhHlpEBaups4VjvO39CPF3zKUcsU5JmKc9lBHpQ=;
 b=osxY6GgUhsZ0he+n8Q8gdjwKFti67fyjfx3eGQa3X5odE2CWbMrSvvKD0chB/lrZcL
 m3kfSTo99FyYBeK/+u78s+d5xGrssK2AFXTJelnJ851Y4SLKPKRwxp9kdhFYZB6KxzMw
 kUaT9ldlXl0usT0y+ex4XpqpwPmliEHceAFH8OkNEQNAcaKkYu654pk9O4DTb8Y594+I
 R9VfISIPMXZZaVO+qIRMcNJb/ZNQYC7g7v+4BW2rCoBT2UuSorUW68a9UqCAr+tsb4nD
 h/r+qSxziLO43Y8mPaGFI2wks7owRJ5yA4H1P4Vm3VwwHT1Hu5+h/VJhWOK05gKeWgji
 MJNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ9DMaOPl/nqtuLQVKib4CZ/S6A/vKpZfl3K4fWFOuZ2Tqe9znwMdwB/L5uuqHp1cB/E8=@dpdk.org
X-Gm-Message-State: AOJu0YxZP8rKjntSZ7wEhAGYZT9nfl1xbRwwus5Tjt74puVMMsbo/zVa
 0cwayjiS1cp4V8vcmTE9DKcFrDoYPNvA3duGjSjYFo6Vjm/EDN1lkjJvNcr9wuxJFkIQZxQVIY+
 IBIj0XyzuPDJ7pOIHroy0padQaWkdP9202ZfQ31b9Eg==
X-Gm-Gg: ASbGnctlzkq8peybEO6LKG8UfzFQCWmC3/1yeGHcgUKathlc4/ULDOzL5rUk/huMnBg
 BpGfY6Fj9OcGUoKNF7h/VhAQX9hc8ZCd/zkhk4/sV1LcqbQfCPZlxLIuTkNfNzPWTEcT/+sfVNU
 HDKeNetYbG51/A6tvtNZa9giRqKqcsvYNGPaJeHhDBsUyf//iToI6HPiF5n+Dta4+ZIkpDUHU1m
 676GFqxgvT96/pdt67jgnwjSIhAiK6jKMb9s84q1zv9oBWaOdvRFL4W7TBQs331GQKwVdSD0ku0
 5WYiNqlJzw==
X-Google-Smtp-Source: AGHT+IHIsvLKO8dEEjTJFMnBukpuZHj2qnipy3UdClCCB3z1o/jTEAxFnucJRFrPYV8+f5QTIZJaHT/bHBWsVvyZsYM=
X-Received: by 2002:a05:690c:a192:b0:784:997d:b86 with SMTP id
 00721157ae682-78929e0cde1mr3209597b3.2.1763060356511; Thu, 13 Nov 2025
 10:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20251017203159.557830-1-dmarx@iol.unh.edu>
 <20251024181606.604135-1-dmarx@iol.unh.edu>
 <20251024181606.604135-2-dmarx@iol.unh.edu>
 <CAJvnSUDywCd9cdjWtpGjpkdB0Mk-dYs+bmra_CKKNhkD6Q44Mg@mail.gmail.com>
In-Reply-To: <CAJvnSUDywCd9cdjWtpGjpkdB0Mk-dYs+bmra_CKKNhkD6Q44Mg@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 13 Nov 2025 13:59:04 -0500
X-Gm-Features: AWmQ_bmit8Q3QXRxckRR4PIeuodgr6kDx9rdwVcKTmkC0I4licZIj1NRQ3u3oy8
Message-ID: <CABD7UXNWR-WY+Oe_JFSCXWfB-vGxQy1=68nDRxH4_x-hHQD0Ng@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dts: add QinQ test suite
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

On Fri, Nov 7, 2025 at 3:15=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:
<snip>
>
> The testcase does look good except that form what I'm seeing, vlan_filter=
 is not supported for 88a8 + 8100 packets (it won't read the 88a8 tag). I s=
ent Bruce and Morten an email about it. But, I think the most reasonable th=
ing is to remove this testcase for the 25.11 release since the expected beh=
avior is either not well defined, or vlan_filter is not supposed to be able=
 to read 88a8 tags.

Agreed, I'll remove this in the new version

<snip>
>> +
>> +            verify(packet is not None, "Packet was dropped when it shou=
ld have been received.")
>> +
>> +            if packet is not None:
>> +                verify(bool(packet.haslayer(Dot1AD)), "QinQ layer not f=
ound in packet")
>
>
> I guess you can also verify that packet haslayer(Dot1Q)

Great point, I hadn't realized the final if statement could be
silently failing if the Dot1Q layer doesn't exist. I'll update this

<snip>
>> +            received_packets1 =3D send_packet_and_capture(test_packets[=
0])
>> +            packet1 =3D self._get_relevant_packet(received_packets1)
>> +            received_packets2 =3D send_packet_and_capture(test_packets[=
1])
>> +            packet2 =3D self._get_relevant_packet(received_packets2)
>> +            received_packets3 =3D send_packet_and_capture(test_packets[=
2])
>> +            packet3 =3D self._get_relevant_packet(received_packets3)
>> +            received_packets4 =3D send_packet_and_capture(test_packets[=
3])
>> +            packet4 =3D self._get_relevant_packet(received_packets4)
>
>
> rename to make them more descriptive? I.e. vlan_packet, 2_vlan_packet, qi=
nq_packet, qinq_vlan_packet? Or similar.

Got it

>
>>
>> +
>> +            testpmd.stop()
>> +
>> +            tests =3D [
>> +                ("Single 8100 tag", self._strip_verify(packet1, False, =
"Single 8100 tag")),
>> +                (
>> +                    "Double 8100 tag",
>> +                    self._strip_verify(packet2, True, "Double 8100 tag"=
),
>> +                ),
>> +                ("Single 88a8 tag", self._strip_verify(packet3, False, =
"Single 88a8 tag")),
>> +                (
>> +                    "QinQ (88a8 and 8100 tags)",
>> +                    self._strip_verify(packet4, False, "QinQ (88a8 and =
8100 tags)"),
>> +                ),
>> +            ]
>
>
> this is good for testing behavior when we have both vlan_strip and qinq_s=
trip enabled. What about when we have only vlan_strip enabled or only qinq_=
strip enabled? I.e. when we have only vlan_strip enabled, and we send an 88=
a8 only packet, nothing should get stripped at all. It probably makes sense=
 to have different testcases for vlan strip, qinq_strip, and vlan_strip + q=
inq_strip.

My logic here was that vlan strip only is being tested in the vlan
suite already, even if it isn't with this set of QinQ style packets. I
think it would make more sense to add those extra cases in the vlan
suite in the future anyways, rather than in the QinQ suite.

I didn't test only qinq strip either because Stephen Hemminger
mentioned it was undefined in this email thread (second message):

https://mail.google.com/mail/u/0/#search/label%3Adev+qinq/FMfcgzQbgJNPMqLMR=
LkTsrxMrfRjJLzq

>
>>
>> +
>> +            failed =3D [ctx for ctx, result in tests if not result]
>> +
>> +            verify(
>> +                not failed,
>> +                f"The following packets were not stripped correctly: {'=
, '.join(failed)}",
>> +            )
>> --
>> 2.51.0
>>
>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
