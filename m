Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B9DCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A560A40151;
	Fri, 24 Oct 2025 20:38:22 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 6DC3F4014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:38:21 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-783fa3aa122so31235407b3.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761331101; x=1761935901; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aR4EreUht4Qk3z7ZYUqLPTf+9SVNhh856blgwnPJr94=;
 b=MleEdZmrnoCdLSA2AuZmO3S70u2/uuZNKETtup5HD76oJdKyxk5geExuiqn6SSSN8G
 ZmVcwbsX3j7hfnb3Su9qaGbRyHB8mzsB9qbqDiaY+ITo24uWg+gXaRmKH3b6S9rubjs4
 kE7sVZ00CzE1bvg1bvf/fqXZyr5LvOmQOE9dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761331101; x=1761935901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aR4EreUht4Qk3z7ZYUqLPTf+9SVNhh856blgwnPJr94=;
 b=eGWcbm9Vc1fTQapYrowvEPyaSys7WmQxdK8HLUcr4Kz6zUuS7f8FrqqtJDQOZDRYkZ
 UbRRUEd6i8u1myzM2aXCHQuY6/U//aZnhN5SIBh5/W7s1ghNnP8SXxwF0+RUIIN6inV+
 0v3ZZ2mbF7W04r4bOTR6QJoBkWT0bV6ZIF7Qe/x+nvsfD1f3pnKTiWiusGTcA5IdugP8
 hgrrv5JFP7m3NSk7pqbHyKiax6ZmQXA/F+o0L2KJYE0w7Byy4zHEyaaD4/99v6DwEFnE
 j8PKiboveBEba6trR+EwNZ3Ufi6FtT2uoO4hIf+5dIBNJa65JDuRyv7f8/cW4tSAlRzJ
 /nrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZYxXptBCEnHzdvW22TUPEVf9jHVsv6wYO1Ryf1ZG7Zejz751rgapXiPUrUzlv09Y7O+c=@dpdk.org
X-Gm-Message-State: AOJu0YwOC+89G7NqdwLocqte/OaskFjwbofR8+LI1aQYRcmJEKP+LoTY
 /LmHWxWO9dkv8H2SHmwcj+Q+/S4bsZ7bueSsd+ACh6mtYQWPQRAUgbrn6aV4GDAeLKwFxcSS9MJ
 nBVmRJR7N7tsP4x2nuBpDzQGG509buo/yK4Ab61d4qg==
X-Gm-Gg: ASbGnctKxtbK4Zv0fYJK1PvCxwEZaRKzQsA5BZ9pckPRTMuCP/Q2jAwz2zduc8g+/5v
 rrueFlbJ0ifb6py/c1jkgcGeaH5gDy3R33R7rK1h3tqDFPXYZVRtEjQzpaBq0yGcUD4dese3K0G
 0/jfJpD5dle0aRFU+BPXvU677mM2QYlrqotxmUmkc7qH0++Kkcsd48JPEeMSIP1zhup0J/kavjl
 NpSUs8dKlMDJqcCAISl3NkiiiBcgXQ8p/zV6DBpIRz0VfacBU0OBIZEP90qLVApElu2jkbdD0x2
 ORI/XeDkeJE=
X-Google-Smtp-Source: AGHT+IGak/zrX0fvhZGN7gLby+puzCVLs3eJzASsdQf8wMhgraXBppwAb83rx28B2BNIJdMtNBb4kuiFQrmZrjaLIg8=
X-Received: by 2002:a05:690c:dcf:b0:784:8bcd:4082 with SMTP id
 00721157ae682-785dd6bbb88mr31797757b3.35.1761331100517; Fri, 24 Oct 2025
 11:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
 <20251003192717.444490-1-dmarx@iol.unh.edu>
 <20251003192717.444490-2-dmarx@iol.unh.edu>
 <CAJvnSUC3gt3McAjK1UWpwtw2ay1YphYMbTZFysnoSEawcmafOg@mail.gmail.com>
In-Reply-To: <CAJvnSUC3gt3McAjK1UWpwtw2ay1YphYMbTZFysnoSEawcmafOg@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 24 Oct 2025 14:38:09 -0400
X-Gm-Features: AS18NWANuzoBwY_4xdqKOL854ssmPQF7Kk4rL314XGUeATOwsrpYdIcvY5fapwc
Message-ID: <CABD7UXM6_11st4Y16hRwgQQk6368V_f5EWT+kQVPHsHyqmrdSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add virtio forwarding test suite
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

>> +"""Virtio forwarding test suite.
>> +
>> +Verify vhost/virtio pvp and loopback topology functionalities.
>
>
> Loopback doesn't seem quite right. Maybe you can just say pvp and fully virtual?

Sure, I'll change that in the pvp_loop docstring as well

>
>>
>> +"""
>> +
>> +from scapy.layers.inet import IP
>> +from scapy.layers.l2 import Ether
>> +
>> +from api.capabilities import LinkTopology
>> +from api.testpmd import TestPmd
>> +from api.testpmd.config import SimpleForwardingModes
>> +from framework.parser import TextParser
>> +from framework.test_suite import TestSuite, func_test
>> +from framework.testbed_model.capability import requires
>> +from framework.testbed_model.linux_session import LinuxSession
>> +from framework.testbed_model.virtual_device import VirtualDevice
>> +
>> +
>> +@requires(topology_type=LinkTopology.TWO_LINKS)
>
>
> two links is true for the pvp test, but the other two dont require any links, right?

Yes good catch, I'll change that around

>
>>
>> +class TestVirtioFwd(TestSuite):
>> +    """Virtio forwarding test suite."""
>> +
>> +    class ForwardingParsers:
>> +        """Class for gathering Rx/Tx packets from testpmd stats."""
>> +
>> +        rx_packets = TextParser.find_int(r"RX-packets:\s*(\d+)")
>> +        tx_packets = TextParser.find_int(r"TX-packets:\s*(\d+)")
>> +
>> +    class vdevs:
>> +        """Class containing virtio-user and vhost-user virtual devices."""
>> +
>> +        virtio_user = VirtualDevice(
>> +            "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
>> +        )
>> +        vhost_user = VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")
>
>
> +1 to Luca's comment about not needing these to be internal classes.

Heard

<snip>
>> +        with TestPmd(
>> +            prefix="virtio",
>> +            vdevs=[VirtualDevice("virtio_user0,path=/dev/vhost-net,queues=1,queue_size=1024")],
>> +        ) as virtio:
>> +            self.sut_node.main_session.send_command("ip link set dev tap0 up", privileged=True)
>> +            with TestPmd(
>> +                prefix="vhost", no_pci=True, vdevs=[VirtualDevice("net_af_packet0,iface=tap0")]
>> +            ) as vhost:
>> +                virtio.set_forward_mode(SimpleForwardingModes.mac)
>> +                vhost.set_forward_mode(SimpleForwardingModes.mac)
>> +                vhost.start()
>> +                virtio.start()
>> +
>> +                packet = Ether() / IP()
>> +                packets = [packet] * 100
>> +                captured_packets = self.send_packets_and_capture(packets)
>> +
>> +                self.verify(
>> +                    len(captured_packets) >= 100, "Sent packets not received on physical interface."
>> +                )
>
>
> Can you remind me what docs you were working from for setting up the pvp test? I'm guessing how you've done it is valid, but I originally thought we needed 2 tap interfaces and that vhost had to run in --no-pci, not virtio. Better safe than sorry. :)

https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html

According to the doc you only need one tap interface. Also the current
implementation already has vhost using --no-pci, not virtio

>
>>
>> --
>> 2.51.0
>>
>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
