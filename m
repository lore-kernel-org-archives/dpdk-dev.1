Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BC9C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 07:55:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBF8B40268;
	Mon, 10 Feb 2025 08:55:29 +0100 (CET)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mails.dpdk.org (Postfix) with ESMTP id C4AB24029A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 15:18:45 +0100 (CET)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-30616d71bb0so10058911fa.3
 for <dev@dpdk.org>; Thu, 06 Feb 2025 06:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738851525; x=1739456325; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yFnZSULp41f+nYFreK8PoeBEZQ18mRhlCj5eA5r5VeA=;
 b=fT38sw9kZALxrMkIu03NkNQjtJNIyU4h74BajVecvX4ACkbA6oMyhp+g1KsaAWUo0v
 T0iC+hk+9bkCOyo69Yk/J4NlCC3xJ2oLnd3U7dNiRZSZ5/8H3XMPq1w/dAA6aSBNCzE5
 HmEg8bmh5UX99NexKarxumy5++YDq+b6GVEsailyHz5a/Hh0YdDDjQKjTSte/hqzjKTU
 EpgaUE1gIew7tcljmiZE6Q4hvh5E+iGPbF2xJBQsf+ozmM87O4CZFjMUx5YuZ5Tfk3Kj
 z50XSe7GadW2Tl0BFb20FaarLJXE5auh4An6enXF9TV0o8G98eniTk9loAvEbfS2ChCt
 RUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738851525; x=1739456325;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yFnZSULp41f+nYFreK8PoeBEZQ18mRhlCj5eA5r5VeA=;
 b=jCITKA2tdYlSHMOjDkHSIsDp3u3Svh5ZN/nEjjI2BXDbF0L9vRB5p9ZX+rgDkFdkR+
 IH2sDoCiauhJHNqGHfQNTYwPKFbUAy1bvlxaQ+KkIWjRp2vpsNpZKJCn3nzpcNJRHbKZ
 rbwDdyoNMZcgTpT3kKbJoEVKtH2znNL4e/YvQEbROr3wa3vZVsuC5f74QcrnrDZ8a+dI
 4XjLJy0IyhGaHVgF+tr5qey1Y6O5GVKSBBchzoYVi0CYR8lajobSNjQQndYg1rI1Hw1X
 MNOpERkfHyu7xBn5nTIQfPzu1/PeHSxxvfBiewfTCbFzOOm4fQr4/9lwqs6L6pOUjz0O
 lHKg==
X-Gm-Message-State: AOJu0YyBeSZVepYauvIrDoVRd1DdBD9fGCs023rdvpW4oMdOwD669W/9
 PZdWiZe0KaqyNp534Mxh6s9ARsrALPQ4SCCajBkzoCi88B/oJLMhIKQwtg0eJti7r5U1RWfEWp9
 3iQRAuc01Z9FMEdPs31a85/NcITitlJcv
X-Gm-Gg: ASbGncs1/5ap1TnAXPta5hYmfEvcShMsb+JcamcoKPrWXxn//DAPqnXuNhlgOWfXsbN
 i3mdNwaMsdCjtmVlXbSFhAlIexVQpVf5InSxUKLgoOS+HmY5dn4TtS+jbylbixCY/GEIc3A==
X-Google-Smtp-Source: AGHT+IHkZ0xBsLTlW/2dJT/ujUF/yO1X6b+hpmXKlkEexCRwCDkcj1S+rkq/xKaJO+rlfEQU5/yQjsD/TGAlvqXDVCQ=
X-Received: by 2002:a2e:a54f:0:b0:300:33b1:f0e1 with SMTP id
 38308e7fff4ca-307cf23dbd9mr24465071fa.0.1738851524442; Thu, 06 Feb 2025
 06:18:44 -0800 (PST)
MIME-Version: 1.0
From: Kevin Stefanov <kevinstefanov15@gmail.com>
Date: Thu, 6 Feb 2025 16:18:26 +0200
X-Gm-Features: AWEUYZlBHGiMVaYYEpnVZDyB6TIcLg_MOQB3E55BZHuDm3ggr1AIfkee3ckDnfM
Message-ID: <CABfNUPGiYdSWrGw+kzx7Mr0CYcGbFAMnzz=yRNbBcc-CpHzzhw@mail.gmail.com>
Subject: Please help me send packets in a newly allocated mbuf.
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006e8124062d79ebaf"
X-Mailman-Approved-At: Mon, 10 Feb 2025 08:55:29 +0100
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

--0000000000006e8124062d79ebaf
Content-Type: text/plain; charset="UTF-8"

Hello, I'm trying to use DPDK for a kernel bypass networking solution at my
new job. I already managed to get it to forward packets that I sent it from
a remote machine, using the basic forwarding example app, but now I'm
trying to craft my own packets from scratch and get tx_burst() to send them
to my remote machine.

I stayed till 5 AM last night trying to get it working, but I couldn't.
Here is my function that takes a pointer to an mbuf, allocates memory for
it from the initialized memory pool, proceeds to fill out Ethernet, IP and
UDP headers, and sets offload flags in mbuf to offload IP and UDP checksum
calculation to the network card:


void allocate_and_populate_packet_mbuf( struct rte_mbuf**   buf_ptr
                                       ,struct rte_mempool* mempool)
{
    const uint16_t PAYLOAD_LEN = 128;
    uint8_t payload[PAYLOAD_LEN];
    const uint16_t PACKET_LEN =  sizeof(struct rte_ether_hdr)
                               + sizeof(struct rte_ipv4_hdr)
                               + sizeof(struct rte_udp_hdr)
                               + PAYLOAD_LEN
                               ;

    struct rte_ether_hdr* ether_hdr;
    struct rte_ipv4_hdr*  ipv4_hdr;
    struct rte_udp_hdr*   udp_hdr;

    char* data;

    uint8_t* payload_addr;

    *((uint64_t*)(payload + 0)) = PACKET_ID;
    memset(payload + 8, 0xF0, PAYLOAD_LEN - 8);

    *buf_ptr = rte_pktmbuf_alloc(mempool);

    (*buf_ptr)->data_len = PACKET_LEN;
    (*buf_ptr)->pkt_len  = PACKET_LEN;

    ether_hdr = rte_pktmbuf_mtod(*buf_ptr, struct rte_ether_hdr *);

    memset(ether_hdr, 0x00, sizeof(struct rte_ether_hdr));

    /*
     * Destination MAC Address       = 0A:40:46:FB:8A:A9
     * Source MAC Address (this NIC) = 0A:C9:6E:32:4D:49
     */

    ether_hdr->dst_addr.addr_bytes[0] = 0x0A;
    ether_hdr->dst_addr.addr_bytes[1] = 0x40;
    ether_hdr->dst_addr.addr_bytes[2] = 0x46;
    ether_hdr->dst_addr.addr_bytes[3] = 0xFB;
    ether_hdr->dst_addr.addr_bytes[4] = 0x8A;
    ether_hdr->dst_addr.addr_bytes[5] = 0xA9;

    ether_hdr->src_addr.addr_bytes[0] = 0x0A;
    ether_hdr->src_addr.addr_bytes[1] = 0xC9;
    ether_hdr->src_addr.addr_bytes[2] = 0x6E;
    ether_hdr->src_addr.addr_bytes[3] = 0x32;
    ether_hdr->src_addr.addr_bytes[4] = 0x4D;
    ether_hdr->src_addr.addr_bytes[5] = 0x49;

    ether_hdr->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);

    ipv4_hdr = rte_pktmbuf_mtod_offset(*buf_ptr, struct rte_ipv4_hdr *,
sizeof(struct rte_ether_hdr));

    memset(ipv4_hdr, 0x00, sizeof(struct rte_ipv4_hdr));

    ipv4_hdr->total_length = rte_cpu_to_be_16(  sizeof(struct rte_ipv4_hdr)
                                              + sizeof(struct rte_udp_hdr)
                                              + PAYLOAD_LEN
                                             );

    ipv4_hdr->time_to_live    = 255;
    ipv4_hdr->next_proto_id = IPPROTO_UDP;
    ipv4_hdr->src_addr      = inet_addr("172.31.32.59");
    ipv4_hdr->dst_addr      = inet_addr("37.63.34.53");
    ipv4_hdr->version_ihl   = 69;
    ipv4_hdr->ihl                = 5;
    ipv4_hdr->version       = 4;

    udp_hdr = rte_pktmbuf_mtod_offset( *buf_ptr
                                      ,struct rte_udp_hdr *
                                      ,sizeof(struct rte_ether_hdr) +
sizeof(struct rte_ipv4_hdr)
                                     );

    udp_hdr->src_port  = rte_cpu_to_be_16(54749);
    udp_hdr->dst_port  = rte_cpu_to_be_16(38686);
    udp_hdr->dgram_len = rte_cpu_to_be_16(sizeof(struct rte_udp_hdr) +
PAYLOAD_LEN);

    /* Also make sure we offload IP checksum and UDP checksum
     * calculation to our network card instead of manually doing it.
     */
     /* This is how the web wiki page says to do it. */
    (*buf_ptr)->l2_len = sizeof(struct rte_ether_hdr);

    (*buf_ptr)->l3_len = sizeof(struct rte_ipv4_hdr);


    (*buf_ptr)->ol_flags |=   RTE_MBUF_F_TX_IPV4
                            | RTE_MBUF_F_TX_IP_CKSUM
                            | RTE_MBUF_F_TX_UDP_CKSUM;


    //(*buf_ptr)->ol_flags = 384;

    (*buf_ptr)->port = 0;
    (*buf_ptr)->packet_type = 528;
    (*buf_ptr)->l2_type = 0;
    (*buf_ptr)->l3_type = 1;
    (*buf_ptr)->l4_type = 2;

    udp_hdr->dgram_cksum = rte_ipv4_phdr_cksum(ipv4_hdr,
(*buf_ptr)->ol_flags);

     /* I don't understand whether I need this call or not. */
     /* I can see my payload and headers already populated */
     /* by the dumped mbuf, even without this call. */
    //data = rte_pktmbuf_append(*buf_ptr, PAYLOAD_LEN);
    /*
    if(data == NULL){
        printf("\n\n[ERR] DPDK: rte_pktmbuf_append(*buf_ptr, PAYLOAD_LEN)
failed!\n\n");
        printf("[ERR] Can't construct packet message buffer!
Returning.\n\n");
        return;
    }
    */

    rte_memcpy(udp_hdr + sizeof(struct rte_udp_hdr), payload, PAYLOAD_LEN);

    return;
}

On return from this function, I call the prepare function on the packet,
because the web wiki says
that this is the function that looks at the offload flags of the mbuf and
calculates the offloaded
checksums. (However, when I print the IPv4 header info after the prepare()
call, it is still
0 for some reason. Is that normal?)

/*
 * The lcore main. This is the main thread that does the work.
 * It generates random 128-byte payloads (first 8 bytes store
 * a constant packet ID so the other side recognizes us) and
 * continuously transmits them, 1 packet at a time.
 */

 /* Basic sending application lcore. 8< */
static __rte_noreturn void
lcore_main(void)
{
        uint16_t port;
        uint64_t test_counter = 0;
        uint64_t burst_counter = 0;
        uint16_t ready_packets = 0;

        /*
         * Check that the port is on the same NUMA node as the polling
thread
         * for best performance.
         */
        RTE_ETH_FOREACH_DEV(port)
                if (rte_eth_dev_socket_id(port) >= 0 &&
                                rte_eth_dev_socket_id(port) !=
                                                (int)rte_socket_id())
                        printf("WARNING, port %u is on remote NUMA node to "
                                        "polling thread.\n\tPerformance
will "
                                        "not be optimal.\n", port);

        printf("\nCore %u forwarding packets. [Ctrl+C to quit]\n",
                        rte_lcore_id());

        /* Main work of application loop. 8< */
        for (;;) {

                /* Go over each NIC connected to a DPDK driver. */
                /* Transmit 1 packet from each NIC. */
                /* For now, just 1 NIC is connected, port id = 0. */
                RTE_ETH_FOREACH_DEV(port) {

                        /* Note that for now, burst size is 1, we send 1
packet at a time. */
                        /* Local array of POINTERS to mbuf objects.
                         * Each pointer is returned by a call to
rte_pktmbuf_alloc(mempool).
                         * This call is made for each packet that must be
sent. Only then
                         * can we start populating the packet's headedrs
and payload.
                         */
                        struct rte_mbuf *bufs[BURST_SIZE];

                        allocate_and_populate_packet_mbuf(&(bufs[0]),
mbuf_pool);

                        /* Check packet correctness and update offloaded
checksums. */

                        ready_packets = rte_eth_tx_prepare(port, 0, bufs,
1);

                        printf("\n\nNumber of packets checked, updated,
ready to send: %u\n", ready_packets);



                        /* Dump a packet to a file for inspection (stdout
here) */
                        rte_pktmbuf_dump(stdout, bufs[0], 256);

                        /* Send burst of TX packets from the same NIC. */

                        const uint16_t nb_tx = rte_eth_tx_burst( port   /*
NIC ID = 0           */
                                                                ,0      /*
TX QUEUE ID          */
                                                                ,bufs   /*
mbuf**               */
                                                                ,1      /*
packets to transmit  */
                                                               );

                        /* Free any unsent packets. */
                        if (unlikely(nb_tx < 1)) {
                                printf("Warning: Only %u packets
transmitted!\n", nb_tx);
                                printf("Manually freeing the mbuf of each
unsent packet.\n");
                                uint16_t buf;
                                for (buf = nb_tx; buf < 1; buf++)
                                        rte_pktmbuf_free(bufs[buf]);
                        }
                }
        }
        /* >8 End of loop. */
}

I am using DPDK 23.11 here, with the AWS ENA poll mode driver, on Amazon
Linux 2023. with igb_uio kernel module.
Again, I got DPDK forwarding to work just fine, but that was when I took
the mbuf given to me by rx_burst(), swap
source and destination MAC and IP addresses and UDP ports, and give the
mbuf to tx_burst().

However, now with my manual allocation of the mbuf and packet data, it's
not working. What am I missing here?
I've verified the IP and MAC addresses multiple times, they work with basic
forwarder, with mbuf returned by rx_burst.

--0000000000006e8124062d79ebaf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGVsbG8sIEkmIzM5O20gdHJ5aW5nIHRvIHVzZSBEUERLIGZvciBhIGtl
cm5lbCBieXBhc3MgbmV0d29ya2luZyBzb2x1dGlvbiBhdCBteSBuZXcgam9iLiBJIGFscmVhZHkg
bWFuYWdlZCB0byBnZXQgaXQgdG8gZm9yd2FyZCBwYWNrZXRzIHRoYXQgSSBzZW50IGl0IGZyb20g
YSByZW1vdGUgbWFjaGluZSwgdXNpbmcgdGhlIGJhc2ljIGZvcndhcmRpbmcgZXhhbXBsZSBhcHAs
IGJ1dCBub3cgSSYjMzk7bSB0cnlpbmcgdG8gY3JhZnQgbXkgb3duIHBhY2tldHMgZnJvbSBzY3Jh
dGNoIGFuZCBnZXQgdHhfYnVyc3QoKSB0byBzZW5kIHRoZW0gdG8gbXkgcmVtb3RlIG1hY2hpbmUu
wqA8YnI+PGJyPkkgc3RheWVkIHRpbGwgNSBBTSBsYXN0IG5pZ2h0IHRyeWluZyB0byBnZXQgaXQg
d29ya2luZywgYnV0IEkgY291bGRuJiMzOTt0LiBIZXJlIGlzIG15IGZ1bmN0aW9uIHRoYXQgdGFr
ZXMgYSBwb2ludGVyIHRvIGFuIG1idWYsIGFsbG9jYXRlcyBtZW1vcnkgZm9yIGl0IGZyb20gdGhl
IGluaXRpYWxpemVkIG1lbW9yeSBwb29sLCBwcm9jZWVkcyB0byBmaWxsIG91dCBFdGhlcm5ldCwg
SVAgYW5kIFVEUCBoZWFkZXJzLCBhbmQgc2V0cyBvZmZsb2FkIGZsYWdzIGluIG1idWYgdG8gb2Zm
bG9hZCBJUCBhbmQgVURQIGNoZWNrc3VtIGNhbGN1bGF0aW9uIHRvIHRoZSBuZXR3b3JrIGNhcmQ6
PGJyPjxicj48Zm9udCBmYWNlPSJtb25vc3BhY2UiPjxicj52b2lkIGFsbG9jYXRlX2FuZF9wb3B1
bGF0ZV9wYWNrZXRfbWJ1Ziggc3RydWN0IHJ0ZV9tYnVmKiogwqAgYnVmX3B0cjxicj7CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCxzdHJ1
Y3QgcnRlX21lbXBvb2wqIG1lbXBvb2wpPGJyPns8YnI+wqAgwqAgY29uc3QgdWludDE2X3QgUEFZ
TE9BRF9MRU4gPSAxMjg7PGJyPsKgIMKgIHVpbnQ4X3QgcGF5bG9hZFtQQVlMT0FEX0xFTl07PGJy
PsKgIMKgIGNvbnN0IHVpbnQxNl90IFBBQ0tFVF9MRU4gPSDCoHNpemVvZihzdHJ1Y3QgcnRlX2V0
aGVyX2hkcik8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqArIHNpemVvZihzdHJ1Y3QgcnRlX2lwdjRfaGRyKTxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgc2l6ZW9mKHN0cnVjdCBydGVfdWRwX2hkcik8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArIFBBWUxPQURf
TEVOPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOzxi
cj48YnI+wqAgwqAgc3RydWN0IHJ0ZV9ldGhlcl9oZHIqIGV0aGVyX2hkcjs8YnI+wqAgwqAgc3Ry
dWN0IHJ0ZV9pcHY0X2hkciogwqBpcHY0X2hkcjs8YnI+wqAgwqAgc3RydWN0IHJ0ZV91ZHBfaGRy
KiDCoCB1ZHBfaGRyOzxicj48YnI+wqAgwqAgY2hhciogZGF0YTs8YnI+PGJyPsKgIMKgIHVpbnQ4
X3QqIHBheWxvYWRfYWRkcjs8YnI+PGJyPsKgIMKgICooKHVpbnQ2NF90KikocGF5bG9hZCArIDAp
KSA9IFBBQ0tFVF9JRDs8YnI+wqAgwqAgbWVtc2V0KHBheWxvYWQgKyA4LCAweEYwLCBQQVlMT0FE
X0xFTiAtIDgpOzxicj48YnI+wqAgwqAgKmJ1Zl9wdHIgPSBydGVfcGt0bWJ1Zl9hbGxvYyhtZW1w
b29sKTs8YnI+PGJyPsKgIMKgICgqYnVmX3B0ciktJmd0O2RhdGFfbGVuID0gUEFDS0VUX0xFTjs8
YnI+wqAgwqAgKCpidWZfcHRyKS0mZ3Q7cGt0X2xlbiDCoD0gUEFDS0VUX0xFTjs8YnI+PGJyPsKg
IMKgIGV0aGVyX2hkciA9IHJ0ZV9wa3RtYnVmX210b2QoKmJ1Zl9wdHIsIHN0cnVjdCBydGVfZXRo
ZXJfaGRyICopOzxicj48YnI+wqAgwqAgbWVtc2V0KGV0aGVyX2hkciwgMHgwMCwgc2l6ZW9mKHN0
cnVjdCBydGVfZXRoZXJfaGRyKSk7PGJyPjxicj7CoCDCoCAvKjxicj7CoCDCoCDCoCogRGVzdGlu
YXRpb24gTUFDIEFkZHJlc3MgwqAgwqAgwqAgPSAwQTo0MDo0NjpGQjo4QTpBOTxicj7CoCDCoCDC
oCogU291cmNlIE1BQyBBZGRyZXNzICh0aGlzIE5JQykgPSAwQTpDOTo2RTozMjo0RDo0OSA8YnI+
wqAgwqAgwqAqLzxicj48YnI+wqAgwqAgZXRoZXJfaGRyLSZndDtkc3RfYWRkci5hZGRyX2J5dGVz
WzBdID0gMHgwQTs8YnI+wqAgwqAgZXRoZXJfaGRyLSZndDtkc3RfYWRkci5hZGRyX2J5dGVzWzFd
ID0gMHg0MDs8YnI+wqAgwqAgZXRoZXJfaGRyLSZndDtkc3RfYWRkci5hZGRyX2J5dGVzWzJdID0g
MHg0Njs8YnI+wqAgwqAgZXRoZXJfaGRyLSZndDtkc3RfYWRkci5hZGRyX2J5dGVzWzNdID0gMHhG
Qjs8YnI+wqAgwqAgZXRoZXJfaGRyLSZndDtkc3RfYWRkci5hZGRyX2J5dGVzWzRdID0gMHg4QTs8
YnI+wqAgwqAgZXRoZXJfaGRyLSZndDtkc3RfYWRkci5hZGRyX2J5dGVzWzVdID0gMHhBOTs8YnI+
PGJyPsKgIMKgIGV0aGVyX2hkci0mZ3Q7c3JjX2FkZHIuYWRkcl9ieXRlc1swXSA9IDB4MEE7PGJy
PsKgIMKgIGV0aGVyX2hkci0mZ3Q7c3JjX2FkZHIuYWRkcl9ieXRlc1sxXSA9IDB4Qzk7PGJyPsKg
IMKgIGV0aGVyX2hkci0mZ3Q7c3JjX2FkZHIuYWRkcl9ieXRlc1syXSA9IDB4NkU7PGJyPsKgIMKg
IGV0aGVyX2hkci0mZ3Q7c3JjX2FkZHIuYWRkcl9ieXRlc1szXSA9IDB4MzI7PGJyPsKgIMKgIGV0
aGVyX2hkci0mZ3Q7c3JjX2FkZHIuYWRkcl9ieXRlc1s0XSA9IDB4NEQ7PGJyPsKgIMKgIGV0aGVy
X2hkci0mZ3Q7c3JjX2FkZHIuYWRkcl9ieXRlc1s1XSA9IDB4NDk7PGJyPjxicj7CoCDCoCBldGhl
cl9oZHItJmd0O2V0aGVyX3R5cGUgPSBydGVfY3B1X3RvX2JlXzE2KFJURV9FVEhFUl9UWVBFX0lQ
VjQpOzxicj48YnI+wqAgwqAgaXB2NF9oZHIgPSBydGVfcGt0bWJ1Zl9tdG9kX29mZnNldCgqYnVm
X3B0ciwgc3RydWN0IHJ0ZV9pcHY0X2hkciAqLCBzaXplb2Yoc3RydWN0IHJ0ZV9ldGhlcl9oZHIp
KTs8YnI+PGJyPsKgIMKgIG1lbXNldChpcHY0X2hkciwgMHgwMCwgc2l6ZW9mKHN0cnVjdCBydGVf
aXB2NF9oZHIpKTs8YnI+PGJyPsKgIMKgIGlwdjRfaGRyLSZndDt0b3RhbF9sZW5ndGggPSBydGVf
Y3B1X3RvX2JlXzE2KCDCoHNpemVvZihzdHJ1Y3QgcnRlX2lwdjRfaGRyKTxicj7CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCArIHNpemVvZihzdHJ1Y3QgcnRlX3VkcF9oZHIpPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICsgUEFZTE9BRF9M
RU48YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqApOzwvZm9udD48ZGl2Pjxmb250IGZhY2U9Im1vbm9zcGFjZSI+PGJy
PsKgIMKgIGlwdjRfaGRyLSZndDt0aW1lX3RvX2xpdmXCoCDCoCA9IDI1NTs8YnI+wqAgwqAgaXB2
NF9oZHItJmd0O25leHRfcHJvdG9faWQgPSBJUFBST1RPX1VEUDs8YnI+wqAgwqAgaXB2NF9oZHIt
Jmd0O3NyY19hZGRyIMKgIMKgIMKgPSBpbmV0X2FkZHIoJnF1b3Q7MTcyLjMxLjMyLjU5JnF1b3Q7
KTs8YnI+wqAgwqAgaXB2NF9oZHItJmd0O2RzdF9hZGRyIMKgIMKgIMKgPSBpbmV0X2FkZHIoJnF1
b3Q7MzcuNjMuMzQuNTMmcXVvdDspOzxicj7CoCDCoCBpcHY0X2hkci0mZ3Q7dmVyc2lvbl9paGwg
wqAgPSA2OTs8YnI+wqAgwqAgaXB2NF9oZHItJmd0O2lobMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ID0gNTs8YnI+wqAgwqAgaXB2NF9oZHItJmd0O3ZlcnNpb24gwqAgwqAgwqAgPSA0Ozxicj48YnI+
wqAgwqAgdWRwX2hkciA9IHJ0ZV9wa3RtYnVmX210b2Rfb2Zmc2V0KCAqYnVmX3B0cjxicj7CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAsc3Ry
dWN0IHJ0ZV91ZHBfaGRyICo8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLHNpemVvZihzdHJ1Y3QgcnRlX2V0aGVyX2hkcikgKyBzaXpl
b2Yoc3RydWN0IHJ0ZV9pcHY0X2hkcik8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqApOzxicj48YnI+wqAgwqAgdWRwX2hkci0mZ3Q7c3Jj
X3BvcnQgwqA9IHJ0ZV9jcHVfdG9fYmVfMTYoNTQ3NDkpOzxicj7CoCDCoCB1ZHBfaGRyLSZndDtk
c3RfcG9ydCDCoD0gcnRlX2NwdV90b19iZV8xNigzODY4Nik7PGJyPsKgIMKgIHVkcF9oZHItJmd0
O2RncmFtX2xlbiA9IHJ0ZV9jcHVfdG9fYmVfMTYoc2l6ZW9mKHN0cnVjdCBydGVfdWRwX2hkcikg
KyBQQVlMT0FEX0xFTik7PGJyPjxicj7CoCDCoCAvKiBBbHNvIG1ha2Ugc3VyZSB3ZSBvZmZsb2Fk
IElQIGNoZWNrc3VtIGFuZCBVRFAgY2hlY2tzdW08YnI+wqAgwqAgwqAqIGNhbGN1bGF0aW9uIHRv
IG91ciBuZXR3b3JrIGNhcmQgaW5zdGVhZCBvZiBtYW51YWxseSBkb2luZyBpdC48YnI+wqAgwqAg
wqAqLzxicj7CoCDCoCDCoC8qIFRoaXMgaXMgaG93IHRoZSB3ZWIgd2lraSBwYWdlIHNheXMgdG8g
ZG8gaXQuICovPGJyPsKgIMKgICgqYnVmX3B0ciktJmd0O2wyX2xlbiA9IHNpemVvZihzdHJ1Y3Qg
cnRlX2V0aGVyX2hkcik7PGJyPjxicj7CoCDCoCAoKmJ1Zl9wdHIpLSZndDtsM19sZW4gPSBzaXpl
b2Yoc3RydWN0IHJ0ZV9pcHY0X2hkcik7PGJyPjxicj7CoCDCoMKgPGJyPsKgIMKgICgqYnVmX3B0
ciktJmd0O29sX2ZsYWdzIHw9IMKgIFJURV9NQlVGX0ZfVFhfSVBWNDxicj7CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IFJURV9NQlVGX0ZfVFhfSVBfQ0tTVU08YnI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfCBSVEVfTUJVRl9GX1RY
X1VEUF9DS1NVTTs8YnI+PGJyPjxicj7CoCDCoCAvLygqYnVmX3B0ciktJmd0O29sX2ZsYWdzID0g
Mzg0Ozxicj48YnI+wqAgwqAgKCpidWZfcHRyKS0mZ3Q7cG9ydCA9IDA7PGJyPsKgIMKgICgqYnVm
X3B0ciktJmd0O3BhY2tldF90eXBlID0gNTI4Ozxicj7CoCDCoCAoKmJ1Zl9wdHIpLSZndDtsMl90
eXBlID0gMDs8YnI+wqAgwqAgKCpidWZfcHRyKS0mZ3Q7bDNfdHlwZSA9IDE7PGJyPsKgIMKgICgq
YnVmX3B0ciktJmd0O2w0X3R5cGUgPSAyOzxicj48YnI+wqAgwqAgdWRwX2hkci0mZ3Q7ZGdyYW1f
Y2tzdW0gPSBydGVfaXB2NF9waGRyX2Nrc3VtKGlwdjRfaGRyLCAoKmJ1Zl9wdHIpLSZndDtvbF9m
bGFncyk7PGJyPjxicj7CoCDCoCDCoC8qIEkgZG9uJiMzOTt0IHVuZGVyc3RhbmQgd2hldGhlciBJ
IG5lZWQgdGhpcyBjYWxsIG9yIG5vdC4gKi88YnI+wqAgwqAgwqAvKiBJIGNhbiBzZWUgbXkgcGF5
bG9hZCBhbmQgaGVhZGVycyBhbHJlYWR5IHBvcHVsYXRlZCAqLzxicj7CoCDCoCDCoC8qIGJ5IHRo
ZSBkdW1wZWQgbWJ1ZiwgZXZlbiB3aXRob3V0IHRoaXMgY2FsbC4gKi88YnI+wqAgwqAgLy9kYXRh
ID0gcnRlX3BrdG1idWZfYXBwZW5kKCpidWZfcHRyLCBQQVlMT0FEX0xFTik7PGJyPsKgIMKgIC8q
PGJyPsKgIMKgIGlmKGRhdGEgPT0gTlVMTCl7PGJyPsKgIMKgIMKgIMKgIHByaW50ZigmcXVvdDtc
blxuW0VSUl0gRFBESzogcnRlX3BrdG1idWZfYXBwZW5kKCpidWZfcHRyLCBQQVlMT0FEX0xFTikg
ZmFpbGVkIVxuXG4mcXVvdDspOzxicj7CoCDCoCDCoCDCoCBwcmludGYoJnF1b3Q7W0VSUl0gQ2Fu
JiMzOTt0IGNvbnN0cnVjdCBwYWNrZXQgbWVzc2FnZSBidWZmZXIhIFJldHVybmluZy5cblxuJnF1
b3Q7KTs8YnI+wqAgwqAgwqAgwqAgcmV0dXJuOzxicj7CoCDCoCB9PGJyPsKgIMKgICovPGJyPjxi
cj7CoCDCoCBydGVfbWVtY3B5KHVkcF9oZHIgKyBzaXplb2Yoc3RydWN0IHJ0ZV91ZHBfaGRyKSwg
cGF5bG9hZCwgUEFZTE9BRF9MRU4pOzxicj48YnI+wqAgwqAgcmV0dXJuOzxicj59PGJyPjwvZm9u
dD48YnI+T24gcmV0dXJuIGZyb20gdGhpcyBmdW5jdGlvbiwgSSBjYWxsIHRoZSBwcmVwYXJlIGZ1
bmN0aW9uIG9uIHRoZSBwYWNrZXQsIGJlY2F1c2UgdGhlIHdlYiB3aWtpIHNheXPCoDxicj50aGF0
IHRoaXMgaXMgdGhlIGZ1bmN0aW9uIHRoYXQgbG9va3MgYXQgdGhlIG9mZmxvYWQgZmxhZ3Mgb2Yg
dGhlIG1idWYgYW5kIGNhbGN1bGF0ZXMgdGhlIG9mZmxvYWRlZDxicj5jaGVja3N1bXMuIChIb3dl
dmVyLCB3aGVuIEkgcHJpbnQgdGhlIElQdjQgaGVhZGVyIGluZm8gYWZ0ZXIgdGhlIHByZXBhcmUo
KSBjYWxsLCBpdCBpcyBzdGlsbMKgPGJyPjAgZm9yIHNvbWUgcmVhc29uLiBJcyB0aGF0IG5vcm1h
bD8pPGJyPjxicj48Zm9udCBmYWNlPSJtb25vc3BhY2UiPi8qPGJyPsKgKiBUaGUgbGNvcmUgbWFp
bi4gVGhpcyBpcyB0aGUgbWFpbiB0aHJlYWQgdGhhdCBkb2VzIHRoZSB3b3JrLjxicj7CoCogSXQg
Z2VuZXJhdGVzIHJhbmRvbSAxMjgtYnl0ZSBwYXlsb2FkcyAoZmlyc3QgOCBieXRlcyBzdG9yZTxi
cj7CoCogYSBjb25zdGFudCBwYWNrZXQgSUQgc28gdGhlIG90aGVyIHNpZGUgcmVjb2duaXplcyB1
cykgYW5kPGJyPsKgKiBjb250aW51b3VzbHkgdHJhbnNtaXRzIHRoZW0sIDEgcGFja2V0IGF0IGEg
dGltZS48YnI+wqAqLzxicj48YnI+wqAvKiBCYXNpYyBzZW5kaW5nIGFwcGxpY2F0aW9uIGxjb3Jl
LiA4Jmx0OyAqLzxicj5zdGF0aWMgX19ydGVfbm9yZXR1cm4gdm9pZDxicj5sY29yZV9tYWluKHZv
aWQpPGJyPns8YnI+wqAgwqAgwqAgwqAgdWludDE2X3QgcG9ydDs8YnI+wqAgwqAgwqAgwqAgdWlu
dDY0X3QgdGVzdF9jb3VudGVyID0gMDs8YnI+wqAgwqAgwqAgwqAgdWludDY0X3QgYnVyc3RfY291
bnRlciA9IDA7PGJyPsKgIMKgIMKgIMKgIHVpbnQxNl90IHJlYWR5X3BhY2tldHMgPSAwOzxicj48
YnI+wqAgwqAgwqAgwqAgLyo8YnI+wqAgwqAgwqAgwqAgwqAqIENoZWNrIHRoYXQgdGhlIHBvcnQg
aXMgb24gdGhlIHNhbWUgTlVNQSBub2RlIGFzIHRoZSBwb2xsaW5nIHRocmVhZDxicj7CoCDCoCDC
oCDCoCDCoCogZm9yIGJlc3QgcGVyZm9ybWFuY2UuPGJyPsKgIMKgIMKgIMKgIMKgKi88YnI+wqAg
wqAgwqAgwqAgUlRFX0VUSF9GT1JFQUNIX0RFVihwb3J0KTxicj7CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAocnRlX2V0aF9kZXZfc29ja2V0X2lkKHBvcnQpICZndDs9IDAgJmFtcDsmYW1wOzxi
cj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBydGVfZXRo
X2Rldl9zb2NrZXRfaWQocG9ydCkgIT08YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKGludClydGVfc29ja2V0
X2lkKCkpPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50ZigmcXVv
dDtXQVJOSU5HLCBwb3J0ICV1IGlzIG9uIHJlbW90ZSBOVU1BIG5vZGUgdG8gJnF1b3Q7PGJyPsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICZxdW90O3BvbGxpbmcgdGhyZWFkLlxuXHRQZXJmb3JtYW5jZSB3aWxsICZxdW90Ozxicj7CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
cXVvdDtub3QgYmUgb3B0aW1hbC5cbiZxdW90OywgcG9ydCk7PGJyPjxicj7CoCDCoCDCoCDCoCBw
cmludGYoJnF1b3Q7XG5Db3JlICV1IGZvcndhcmRpbmcgcGFja2V0cy4gW0N0cmwrQyB0byBxdWl0
XVxuJnF1b3Q7LDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBydGVfbGNv
cmVfaWQoKSk7PGJyPjxicj7CoCDCoCDCoCDCoCAvKiBNYWluIHdvcmsgb2YgYXBwbGljYXRpb24g
bG9vcC4gOCZsdDsgKi88YnI+wqAgwqAgwqAgwqAgZm9yICg7Oykgezxicj48YnI+wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgLyogR28gb3ZlciBlYWNoIE5JQyBjb25uZWN0ZWQgdG8gYSBEUERLIGRy
aXZlci4gKi88YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogVHJhbnNtaXQgMSBwYWNrZXQg
ZnJvbSBlYWNoIE5JQy4gKi88YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogRm9yIG5vdywg
anVzdCAxIE5JQyBpcyBjb25uZWN0ZWQsIHBvcnQgaWQgPSAwLiAqLzxicj7CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBSVEVfRVRIX0ZPUkVBQ0hfREVWKHBvcnQpIHs8YnI+PGJyPsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIE5vdGUgdGhhdCBmb3Igbm93LCBidXJzdCBzaXpl
IGlzIDEsIHdlIHNlbmQgMSBwYWNrZXQgYXQgYSB0aW1lLiAqLzxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBMb2NhbCBhcnJheSBvZiBQT0lOVEVSUyB0byBtYnVmIG9i
amVjdHMuPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBFYWNoIHBv
aW50ZXIgaXMgcmV0dXJuZWQgYnkgYSBjYWxsIHRvIHJ0ZV9wa3RtYnVmX2FsbG9jKG1lbXBvb2wp
Ljxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogVGhpcyBjYWxsIGlz
IG1hZGUgZm9yIGVhY2ggcGFja2V0IHRoYXQgbXVzdCBiZSBzZW50LiBPbmx5IHRoZW48YnI+wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIGNhbiB3ZSBzdGFydCBwb3B1bGF0
aW5nIHRoZSBwYWNrZXQmIzM5O3MgaGVhZGVkcnMgYW5kIHBheWxvYWQuPGJyPsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKi88YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgc3RydWN0IHJ0ZV9tYnVmICpidWZzW0JVUlNUX1NJWkVdOzxicj48YnI+wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWxsb2NhdGVfYW5kX3BvcHVsYXRlX3Bh
Y2tldF9tYnVmKCZhbXA7KGJ1ZnNbMF0pLCBtYnVmX3Bvb2wpOzxicj48YnI+wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogQ2hlY2sgcGFja2V0IGNvcnJlY3RuZXNzIGFuZCB1
cGRhdGUgb2ZmbG9hZGVkIGNoZWNrc3Vtcy4gKi88L2ZvbnQ+PC9kaXY+PGRpdj48Zm9udCBmYWNl
PSJtb25vc3BhY2UiPjxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWFk
eV9wYWNrZXRzID0gcnRlX2V0aF90eF9wcmVwYXJlKHBvcnQsIDAsIGJ1ZnMsIDEpOzxicj48YnI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnRmKCZxdW90O1xuXG5OdW1i
ZXIgb2YgcGFja2V0cyBjaGVja2VkLCB1cGRhdGVkLCByZWFkeSB0byBzZW5kOiAldVxuJnF1b3Q7
LCByZWFkeV9wYWNrZXRzKTs8YnI+PGJyPjxicj48YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgLyogRHVtcCBhIHBhY2tldCB0byBhIGZpbGUgZm9yIGluc3BlY3Rpb24gKHN0
ZG91dCBoZXJlKSAqLzxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBydGVf
cGt0bWJ1Zl9kdW1wKHN0ZG91dCwgYnVmc1swXSwgMjU2KTs8YnI+PGJyPsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIFNlbmQgYnVyc3Qgb2YgVFggcGFja2V0cyBmcm9tIHRo
ZSBzYW1lIE5JQy4gKi88YnI+PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGNvbnN0IHVpbnQxNl90IG5iX3R4ID0gcnRlX2V0aF90eF9idXJzdCggcG9ydCDCoCAvKiBOSUMg
SUQgPSAwIMKgIMKgIMKgIMKgIMKgICovPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICwwIMKgIMKgIMKgLyogVFggUVVFVUUgSUQgwqAgwqAgwqAgwqAgwqAqLzxicj7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAsYnVmcyDCoCAvKiBtYnVmKiog
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgLDEgwqAgwqAgwqAvKiBwYWNrZXRzIHRvIHRyYW5zbWl0IMKgKi88YnI+wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqApOzxicj48YnI+wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogRnJlZSBhbnkgdW5zZW50IHBhY2tldHMuICovPGJyPsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICh1bmxpa2VseShuYl90eCAmbHQ7
IDEpKSB7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHByaW50ZigmcXVvdDtXYXJuaW5nOiBPbmx5ICV1IHBhY2tldHMgdHJhbnNtaXR0ZWQhXG4mcXVv
dDssIG5iX3R4KTs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcHJpbnRmKCZxdW90O01hbnVhbGx5IGZyZWVpbmcgdGhlIG1idWYgb2YgZWFjaCB1bnNl
bnQgcGFja2V0LlxuJnF1b3Q7KTs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgdWludDE2X3QgYnVmOzxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmb3IgKGJ1ZiA9IG5iX3R4OyBidWYgJmx0OyAxOyBidWYr
Kyk8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcnRlX3BrdG1idWZfZnJlZShidWZzW2J1Zl0pOzxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+wqAg
wqAgwqAgwqAgfTxicj7CoCDCoCDCoCDCoCAvKiAmZ3Q7OCBFbmQgb2YgbG9vcC4gKi88YnI+fTwv
Zm9udD48YnI+PGJyPkkgYW0gdXNpbmcgRFBESyAyMy4xMSBoZXJlLCB3aXRoIHRoZSBBV1MgRU5B
IHBvbGwgbW9kZSBkcml2ZXIsIG9uIEFtYXpvbiBMaW51eCAyMDIzLiB3aXRoIGlnYl91aW8ga2Vy
bmVsIG1vZHVsZS48YnI+QWdhaW4sIEkgZ290IERQREsgZm9yd2FyZGluZyB0byB3b3JrIGp1c3Qg
ZmluZSwgYnV0IHRoYXQgd2FzIHdoZW4gSSB0b29rIHRoZSBtYnVmIGdpdmVuIHRvIG1lIGJ5IHJ4
X2J1cnN0KCksIHN3YXA8YnI+c291cmNlIGFuZCBkZXN0aW5hdGlvbiBNQUMgYW5kIElQIGFkZHJl
c3NlcyBhbmQgVURQIHBvcnRzLCBhbmQgZ2l2ZSB0aGUgbWJ1ZiB0byB0eF9idXJzdCgpLjxicj48
YnI+SG93ZXZlciwgbm93IHdpdGggbXkgbWFudWFsIGFsbG9jYXRpb24gb2YgdGhlIG1idWYgYW5k
IHBhY2tldCBkYXRhLCBpdCYjMzk7cyBub3Qgd29ya2luZy4gV2hhdCBhbSBJIG1pc3NpbmcgaGVy
ZT88YnI+SSYjMzk7dmUgdmVyaWZpZWQgdGhlIElQIGFuZCBNQUMgYWRkcmVzc2VzIG11bHRpcGxl
IHRpbWVzLCB0aGV5IHdvcmsgd2l0aCBiYXNpYyBmb3J3YXJkZXIsIHdpdGggbWJ1ZiByZXR1cm5l
ZCBieSByeF9idXJzdC48YnI+PGJyPjwvZGl2PjwvZGl2Pg0K
--0000000000006e8124062d79ebaf--
